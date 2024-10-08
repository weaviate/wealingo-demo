
from django.template import Context
from django.template.loader import get_template
import logging

logger = logging.getLogger(__name__)

def create_prompt(questions, query):
    logger.debug('in create prompt:')
    template = get_template('prompts/generate_prompt.html')
    context = {
        'questions': questions,
        # 'category':category,
        'query': query
    }
    rendered_output = template.render(context)
    logger.debug(rendered_output)
    return rendered_output