PYTHON_EXEC:=python3
PIP_EXEC:=pip
PIP_COMPILE:=pip-compile
PIP_SYNC:=pip-sync

COMP_VENV:=. compile-venv/bin/activate

compile-venv:
	$(PYTHON_EXEC) -m venv $@
	$(COMP_VENV) && $(PIP_EXEC) install pip-tools

%.txt: %.in compile-venv
	$(COMP_VENV) && $(PIP_COMPILE) $< > $@

%-venv: requirements-%.txt
	$(PYTHON_EXEC) -m venv $@
	. $@/bin/activate && $(PIP_EXEC) install pip-tools
	. $@/bin/activate && $(PIP_SYNC) $<
