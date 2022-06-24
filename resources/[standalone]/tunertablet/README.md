## How to install
1. If you are using qb-tunerchip or any other nitrous system then you will have to remove it. 
2. If you want to use the multi item system for nitrous then follow below, otherwise skip to step 5
3. Add images to your inventory/ html/ images
4. Add the snippet below to your core/ shared/ items
```
    ['small-nitrous-bottle'] = { ['name'] = 'small-nitrous-bottle', ['label'] = 'Small Nos bottle', ['weight'] = 5000, ['type'] = 'item', ['image'] = 'small-nitrous-bottle.png', ['unique'] = true, ['useable'] = true, ['shouldClose'] = true, ['combinable'] = nil, ['description'] = 'Car go burr' },

    ['medium-nitrous-bottle'] = { ['name'] = 'medium-nitrous-bottle', ['label'] = 'Medium Nos bottle', ['weight'] = 7500, ['type'] = 'item', ['image'] ='medium-nitrous-bottle.png', ['unique'] = true, ['useable'] = true, ['shouldClose'] = true, ['combinable'] = nil,['description'] = 'Car go burr' },

    ['large-nitrous-bottle'] = { ['name'] = 'large-nitrous-bottle', ['label'] = 'Large Nos bottle', ['weight'] = 10000, ['type'] = 'item', ['image'] = 'large-nitrous-bottle.png', ['unique'] = true, ['useable'] = true, ['shouldClose'] = true, ['combinable'] = nil, ['description'] = 'Car go burr' },

    ['extra-large-nitrous-bottle'] = { ['name'] = 'extra-large-nitrous-bottle', ['label'] = 'Extra Large Nos bottle', ['weight'] = 12500, ['type'] = 'item', ['image'] = 'extra-large-nitrous-bottle.png', ['unique'] = true, ['useable'] = true, ['shouldClose'] = true, ['combinable'] = nil, ['description'] = 'Car go burr' },

```
5. Drag and drop tunertablet to your resources folder
6. Add "start tunertablet" to your server..cfg
7. Enjoy


## Dependencies
- [qb-core](https://github.com/qbcore-framework/qb-core)
- [qb-hud](https://github.com/qbcore-framework/qb-hud) - For NOS status display

## Screenshots
![PURGE](https://media.discordapp.net/attachments/910218898341769236/938217824927776808/screenshot.jpg?width=1037&height=583)

## Features
- Vehicle tuning with Tuner Tablet (Item name: tunerlaptop)
- Usable NOS for vehicles (Item name: nitrous)