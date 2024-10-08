import requests
import json
import re
import logging

logger = logging.getLogger(__name__)

WEAVIATE_URL = "https://ABC.weaviate.cloud"  
WEAVIATE_GRAPHQL = WEAVIATE_URL + "/v1/graphql"
WEAVIATE_API_KEY = ""  
OPENAI_API_KEY = ""
COHERE_API_KEY = ""

def perform_search(query, near_text="", limit=3):
    graphql_query = """
    {
      Get {
        ConversationalStatements(
          hybrid: {
            query: "%s"
            alpha: 0.75
            properties: ["question"] 
          }     
          limit: %d
        ) {
          question
          answer
          instruction
          _additional { 
            score               
          }
        }
      }
    }
    """ % (query, limit)
    
    headers = {
        "Content-Type": "application/json",
        "Authorization": f"Bearer {WEAVIATE_API_KEY}",
        "X-OpenAI-Api-Key": OPENAI_API_KEY,
        'X-Cohere-Api-Key': COHERE_API_KEY
    }
    
    response = requests.post(WEAVIATE_GRAPHQL, json={'query': graphql_query}, headers=headers)
    
    if response.status_code == 200:
        data = response.json()
        print(data)
        results = data['data']['Get']['ConversationalStatements']
        logger.info(results)    
        return results
    else:
        raise Exception(f"Query failed with status code {response.status_code}: {response.text}")


def generate_text_with_prompt(prompt, query, additional_context=None):
    escaped_prompt = prompt.replace('"', '\\"')
    graphql_query = """
    {
      Get {
        ConversationalStatements (          
          nearText: {
            concepts: ["%s"],
            certainty : 0.7
          }
          limit: 10
        ) {
          question
          answer
          _additional {
            generate(
              groupedResult: {
                task: \"\"\"%s\"\"\"
              }
            ) {
              groupedResult
              error
            }
          }
        }
      }
    }
    """ % (query, escaped_prompt)
    
    headers = {
        "Content-Type": "application/json",
        "Authorization": f"Bearer {WEAVIATE_API_KEY}",
        "X-OpenAI-Api-Key": OPENAI_API_KEY,
    }
    
    response = requests.post(WEAVIATE_GRAPHQL, json={'query': graphql_query}, headers=headers)
    if response.status_code == 200:
        data = response.json()
        logger.debug(data)
        grouped_result_str = data['data']['Get']['ConversationalStatements'][0]['_additional']['generate']['groupedResult']
        cleaned_json_str = grouped_result_str.strip('```json')
        logger.debug(cleaned_json_str)
        try:
            grouped_result_json = json.loads(cleaned_json_str)
        except json.JSONDecodeError as e:
            logger.debug(f"Failed to decode JSON: {e}")      
        return grouped_result_json
    else:
        raise Exception(f"Query failed with status code {response.status_code}: {response.text}")


