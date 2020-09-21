
##############################
#	CONDITIONAL STATEMENTS	
##############################

####### THEMES & PLUGINS DIRECTORIES ######
# Assign home folders for theme & plugin
wpThemeDir = /${WORDPRESS_THEME_FOLDER}
wpPluginDir = $(wpThemeDir)/${WORDPRESS_THEME_PLUGIN_FOLDER}

####### CHECKING LOCAL & REPO THEMES ######
# Check if both local & repo theme variables are not empty
ifneq "$(and ${WORDPRESS_LOCAL_THEMES},${WORDPRESS_REPO_THEMES})" ""
	# Loop all theme then assign it with the theme path diretory
	localThemes := $(foreach theme,${WORDPRESS_LOCAL_THEMES},$(wpThemeDir)/$(theme))
	# Combine all local & repo themes
	wpThemes := $(localThemes) ${WORDPRESS_REPO_THEMES}

# Check if local theme is not empty
else ifneq ($(strip ${WORDPRESS_LOCAL_THEMES}),)
	# Loop all themes then assign it with the theme path diretory
	localThemes := $(foreach theme,${WORDPRESS_LOCAL_THEMES},$(wpThemeDir)/$(theme))
	wpThemes := $(localThemes)

# Check if repo theme is not empty
else ifneq ($(strip ${WORDPRESS_REPO_THEMES}),)
	wpThemes := ${WORDPRESS_REPO_THEMES}
endif

####### CHECKING LOCAL & REPO PLUGINS ######
# Check if both local & repo plugin variables are not empty
ifneq "$(and ${WORDPRESS_LOCAL_PLUGINS},${WORDPRESS_REPO_PLUGINS})" ""
	# Loop all plugins then assign it with the plugin path diretory
	localPlugins := $(foreach plugin,${WORDPRESS_LOCAL_PLUGINS},$(wpPluginDir)/$(plugin))
	# Combine all local & repo plugins
	wpPlugins := $(localPlugins) ${WORDPRESS_REPO_PLUGINS}

# Check if local plugin is not empty
else ifneq ($(strip ${WORDPRESS_LOCAL_PLUGINS}),)
	# Loop all plugins then assign it with the plugin path diretory
	localPlugins := $(foreach plugin,${WORDPRESS_LOCAL_PLUGINS},$(wpPluginDir)/$(plugin))
	wpPlugins := $(localPlugins)

# Check if repo plugin is not empty
else ifneq ($(strip ${WORDPRESS_REPO_PLUGINS}),)
	wpPlugins := ${WORDPRESS_REPO_PLUGINS}
endif

#################
#	COMMANDS	
#################
install: configure

configure:

	@echo "⚙️ Configuring Wordpress parameters..."
	wp core install \
		--url=${WORDPRESS_WEBSITE_URL_WITHOUT_HTTP} \
		--title="${WORDPRESS_WEBSITE_TITLE}" \
		--admin_user=${WORDPRESS_ADMIN_USER} \
		--admin_password=${WORDPRESS_ADMIN_PASSWORD} \
		--admin_email=${WORDPRESS_ADMIN_EMAIL}

	@echo -e "\n⚙️ Update default site url..."
	wp option update siteurl ${WORDPRESS_WEBSITE_URL}
	wp rewrite structure $(WORDPRESS_WEBSITE_POST_URL_STRUCTURE)

ifdef wpThemes
	@echo -e "\n⚙️ Install & activate themes ..."
	-wp theme install --activate ${wpThemes}
endif

ifdef wpPlugins
	@echo -e "\n⚙️ Install & activate plugins..."
	-wp plugin install --activate $(wpPlugins)
endif

	@echo -e "\n⚙️ Removing Wordpress default themes..."
	-wp theme delete ${WORDPRESS_DEFAULT_THEMES}

	@echo -e "\n⚙️ Removing Wordpress default plugins..."
	-wp plugin delete ${WORDPRESS_DEFAULT_PLUGINS}

	@echo -e "\n⚙️ Removing Wordpress default posts & pages..."
	-wp post delete --force ${WORDPRESS_DEFAULT_POSTS_PAGES}