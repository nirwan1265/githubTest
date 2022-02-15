library(tidyr)

georef <- read.csv(file = "georef.csv", na.strings = "NA")
head(georef)


hapmap <- read.table("genotype_ids.txt", header = F)
colnames(hapmap)[1] = "hapmap_id"
head(hapmap)

by_IS <- georef %>%
  inner_join(hapmap, by = c(is_no = "V2")) %>% print()

by_PI <- georef %>%
  inner_join(hapmap, by = c(pi = "V2")) %>% print()

geo_hap <-  rbind(
  georef %>%
    inner_join(hapmap, by = c(is_no = "V2")),
  georef %>%
    inner_join(hapmap, by = c(pi = "V2")) 
) %>%
  group_by(hapmap_id, Latitude, Longitude) %>%
  summarise(count = length(hapmap_id)) %>%
  arrange(-count) 


head(geo_hap)
head(hapmap)

unique_hapmap <- intersect(geo_hap,hapmap, by="hapmap_id")

a <- geo_hap[,1]
b <- as.data.frame(hapmap[,1])
c <- rbind(a,b)
write.csv(c,"uniquemaps.csv")

print("Hello")
