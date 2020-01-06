const fs = require('fs')
const tokenColors = require('Material-theme/themes/OneDark-Pro-bold.json').tokenColors
const workbenchThemes = [
  {
    id: 'mirage',
    name: 'Mirage',
    colors: require('ayu/ayu-mirage.json').colors
  },
  {
    id: 'mirage-bordered',
    name: 'Mirage Bordered',
    colors: require('ayu/ayu-mirage-bordered.json').colors
  },
  {
    id: 'dark',
    name: 'Dark',
    colors: require('ayu/ayu-dark.json').colors
  },
  {
    id: 'dark-bordered',
    name: 'Dark Bordered',
    colors: require('ayu/ayu-dark-bordered.json').colors
  }
]

// begin syntax edits
const jsVarColors = tokenColors.find(e => e.name === 'js variable readwrite')
jsVarColors.scope = jsVarColors.scope.split(',').filter(s => s !== 'meta.object-literal.key').join()
tokenColors.push({
    name: 'js object key',
    scope: 'meta.object-literal.key',
    settings: {
      foreground: '#56b6c2'
    }
})
tokenColors.find(e => e.name === 'Attribute IDs').settings.fontStyle = ''
tokenColors.find(e => e.name === 'Attribute class').settings.fontStyle = ''
// end syntax edits

for (const { id, name, colors } of workbenchThemes) {
  // begin workbench edits
  colors['editorGroup.emptyBackground'] = colors['editorGroup.background']
  colors['editorGroup.background'] = undefined
  colors['gitDecoration.conflictingResourceForeground'] = colors['gitDecoration.deletedResourceForeground']
  // end workbench edits
  const theme = {
    name: `Ayu One Dark Pro | ${name}`,
    type: 'dark',
    colors,
    tokenColors
  }
  const themeJSON = JSON.stringify(theme, '', 2)
  fs.writeFileSync(`./themes/ayu-one-dark-pro-${id}-color-theme.json`, themeJSON)
}
