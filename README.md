# DrugProcess
A lightweight FiveM resource for drug processing mechanics. This script provides a streamlined system for converting bulk narcotics (weed/cocaine bricks) into individual sales units (baggies).

## Features
- Configurable drug processing mechanics
- Support for multiple weed strain types
- Customizable output quantities
- Integration with ox_ framework suite
- Minimal performance impact
- Easy configuration through server-side settings

## Dependencies
The following resources are required for proper functionality:
- ox_lib
- ox_target
- ox_inventory

## Configuration
### Weed Strains
You can customize available weed strains by modifying the `weedtypes` table in the configuration. Each strain can have unique properties and output quantities.

Example configuration:
```lua
local weedtypes = {
    "og_kush",
    "purple_haze",
    "white_widow"
    -- Add additional strains as needed
}
```

### Output Quantities
Adjust processing output quantities in the server file to match your server's economy:
- Modify the conversion ratios
- Customize processing time
- Configure minimum/maximum output amounts

## Installation
1. Ensure all dependencies are installed and up-to-date
2. Copy the resource to your server's resources folder
3. Add `ensure symple_drugprocess` to your server.cfg
4. Configure the script settings to match your server's requirements
5. Restart your server

## Support
For issues, feature requests, or configuration help:
- Create an issue in the repository
- Join our Discord community https://discord.gg/chztgqAg






