# Load the Pagy::Backend module
require "pagy/extras/bootstrap"
require "pagy/extras/overflow"

# Set Pagy::DEFAULT options
Pagy::DEFAULT[:items] = 15
Pagy::DEFAULT[:overflow] = :last_page
