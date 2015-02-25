# Makefile autogenerated by Dyi on {{info.today}}
#
# Main target: {{options.defaultGoal}}
# 

.DEFAULT_GOAL := {{options.defaultGoal}}

{% for p in data.phonyTargets %}
.PHONY: {{p.name}}
{{p.name}}:{% for x in p.dependencies %} {{x}}{% endfor %} 

{% endfor %}

{% for p in data.phonySequentialTargets %}
.PHONY: {{p.name}}
{{p.name}}: {% for x in p.dependencies %} 
	make {{x}} 
{% endfor %} 
{% for a in p.actions %}	{{a}}
{% endfor %}
{% endfor %}

{% for t in data.targets %}
{{t.name}}: {% for x in t.dependencies %}{{x}} {% endfor %}
	{{t.command}}	
{% endfor %}
