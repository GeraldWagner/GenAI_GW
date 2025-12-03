# JupyterLab Configuration for GenAI_GW

# Disable authentication for local development
c.ServerApp.token = ''
c.ServerApp.password = ''

# Allow all origins (for local development)
c.ServerApp.allow_origin = '*'

# Disable XSRF checks (local development only)
c.ServerApp.disable_check_xsrf = True

# Set default working directory
c.ServerApp.root_dir = '/workspace'

# Enable JupyterLab by default
c.ServerApp.default_url = '/lab'

# Terminal settings
c.ServerApp.terminals_enabled = True

# File browser settings
c.FileContentsManager.delete_to_trash = False

# Autosave interval (in seconds)
c.FileContentsManager.autosave_interval = 60

# Performance settings
c.NotebookApp.max_buffer_size = 104857600  # 100MB

# Logging
c.Application.log_level = 'INFO'
