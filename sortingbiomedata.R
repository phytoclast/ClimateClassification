summaryBiome <- readRDS('figures/summaryBiome.RDS')

summaryBiome <- summaryBiome[with(summaryBiome, order(Temperature,Moisture, -count)),]


summaryBiome$Climate <- paste(summaryBiome$Temperature, summaryBiome$Moisture)

summaryBiome$Moisture <-  ifelse(summaryBiome$Moisture %in% c('Isopluvial', 'Moist Pluviothermic', 'Moist Xerothermic') &
                                   summaryBiome$Temperature %in% c('Alpine', 'Boreal', 'Andean'), 'Moist', summaryBiome$Moisture )
summaryBiome$Moisture <-  ifelse(summaryBiome$Moisture %in% c('Isoxeric', 'Dry Pluviothermic', 'Dry Xerothermic') &
                                   summaryBiome$Temperature %in% c('Alpine', 'Boreal', 'Andean'), 'Dry', summaryBiome$Moisture )

summaryBiome$Moisture <-  ifelse(summaryBiome$Moisture %in% c('Moist Xerothermic') &
                                   summaryBiome$Temperature %in% c('Hot Tropical', 'Warm Tropical'), 'Moist Pluviothermic', summaryBiome$Moisture)

summaryBiome$Temperature <-  ifelse(!summaryBiome$Moisture %in% c('Isopluvial') &
                                      summaryBiome$Temperature %in% c('Warm Tropical', 'Hot Tropical'),'Tropical',  summaryBiome$Temperature)
summaryBiome$Temperature <-  ifelse(!summaryBiome$Moisture %in% c('Isopluvial') &
                                      summaryBiome$Temperature %in% c('Subtropical', 'Hemi-Subtropical'),'Subtropical',  summaryBiome$Temperature)
summaryBiome$Temperature <-  ifelse(!summaryBiome$Moisture %in% c('Isopluvial') &
                                      summaryBiome$Temperature %in% c('Cool Oceanic', 'Mild Oceanic'), 'Oceanic', summaryBiome$Temperature)
summaryBiome$Temperature <-  ifelse(!summaryBiome$Moisture %in% c('Isopluvial') &
                                      summaryBiome$Temperature %in% c('Hemiboreal', 'Mild Temperate', 'Warm Temperate'), 'Temperate', summaryBiome$Temperature)

summaryBiome$Climate <- paste(summaryBiome$Temperature, summaryBiome$Moisture)

Biome <- aggregate(summaryBiome[,c('count')], by=list(summaryBiome$Climate, summaryBiome$name), FUN='sum')
colnames(Biome) <- c('Climate', 'name', 'count')
Biome <- Biome[with(Biome, order(Climate, -count)),]
Biometotals <- aggregate(Biome[,c('count')], by=list(Biome$name), FUN='sum')
colnames(Biometotals) <- c('name', 'total')
Biome <- merge(Biome, Biometotals, by='name')
Biome$aff <- Biome$count/Biome$total*100

Biome <- Biome[with(Biome, order(Climate, -aff)),]


