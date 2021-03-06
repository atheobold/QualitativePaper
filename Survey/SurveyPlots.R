library(dplyr)
library(pander)
library(ggplot2)
library(gridExtra)

survey <- read.csv("all_participants.csv", stringsAsFactors = T)

colnames(survey) <- c("Time", "Name", "Program", "Degree", "Prereq", 
                      "CS_courses", "Languages", "Stat_courses", "Other_Stat",
                      "Other_Courses", "Independent_Research", "CS_Interest",
                      "Stat_Interest", "Research_Amount", "Participate",
                      "Enrolled")

survey$Research_Amount <- paste(survey$Independent_Research, ", ", 
                                survey$Research_Amount, sep = "")

survey$CS_courses <- as.factor(survey$CS_courses)
survey$Stat_courses <- as.factor(survey$Stat_courses)
survey$CS_Interest <- as.factor(survey$CS_Interest)
survey$Stat_Interest <- as.factor(survey$Stat_Interest)

survey$Program[6:7] <- "Fish and Wildlife Management"
survey$Program[c(1, 4, 8, 9)] <- "LRES"
survey$Program <- droplevels(survey$Program)


survey$Program <- factor(survey$Program, levels = c("LRES", "Animal Bioscience", 
                                                "Fish and Wildlife Management", 
                                                "Ecology", 
                                                "Animal Range Science"))
survey$Program[3] <- "Animal Range Science"

############################## TABLES ######################################

pander(group_by(survey, Degree) %>% summarise(count = n_distinct(Name)), 
       caption = "Survey Participant Degrees")

pander(group_by(survey, Program) %>% summarise(count = n_distinct(Name)), 
       caption = "Survey Participant Programs")

pander(group_by(survey, Prereq) %>% summarise(count = n_distinct(Name)), 
       caption = "Survey Participant Stat 511 Enrolled")

pander(group_by(survey, CS_courses) %>% summarise(count = n_distinct(Name)), 
       caption = "Survey Participant Number of CS Courses")

pander(group_by(survey, Languages) %>% summarise(count = n_distinct(Name)), 
       caption = "Survey Participant CS Languages")

pander(group_by(survey, Stat_courses) %>% summarise(count = n_distinct(Name)), 
       caption = "Survey Participant Number of Stat Courses")

pander(group_by(survey, Research_Amount) %>% 
         summarise(count = n_distinct(Name)), 
       caption = "Survey Participant Independent Research Amount")

pander(group_by(survey, CS_Interest) %>% 
         summarise(count = n_distinct(Name)), 
       caption = "Survey Participant CS Course Interest")

pander(group_by(survey, Stat_Interest) %>% 
         summarise(count = n_distinct(Name)), 
       caption = "Survey Participant Stat/CS Career Interest")

############################# PLOTS ########################################

degree <- group_by(survey, Degree) %>% summarise(count = n_distinct(Name))

program <- group_by(survey, Program) %>% summarise(count = n_distinct(Name))

prereq <- group_by(survey, Prereq) %>% summarise(count = n_distinct(Name))

cs_course <- group_by(survey, CS_courses) %>% summarise(count = n_distinct(Name))

languages <- group_by(survey, Languages) %>% summarise(count = n_distinct(Name))

stat_course <- group_by(survey, Stat_courses) %>% 
  summarise(count = n_distinct(Name))

research <- group_by(survey, Research_Amount) %>% 
         summarise(count = n_distinct(Name))

CS_interest <- group_by(survey, CS_Interest) %>% 
         summarise(count = n_distinct(Name))

Stat_Career <- group_by(survey, Stat_Interest) %>% 
         summarise(count = n_distinct(Name))


p <- ggplot(degree, aes(x = Degree, y = count, colour = Degree, 
                              fill = Degree)) +
  geom_bar(stat = "identity") +
  coord_cartesian(ylim = c(0, 7)) + 
  geom_text(data = degree, aes(label = count,
                                     y = count + 0.45), size = 6) + 
  theme(legend.background = element_rect(colour = "black"), 
        axis.text.x = element_blank(), 
        axis.text.y = element_blank()) +
  theme(plot.title = element_text(size = rel(2), colour = "blue"), 
        axis.title.y = element_text(size = rel(1.2), colour = "black")) +
  labs(list(title = "Survey Participant Degrees", x = "", 
            y = "Number of Students"))

q <- ggplot(program, aes(x = Program, y = count, colour = Program, 
                        fill = Program)) +
  geom_bar(stat = "identity") +
  coord_cartesian(ylim = c(0, 5)) + 
  geom_text(data = program, aes(label = count,
                               y = count + 0.45), size = 6) + 
  theme(legend.background = element_rect(colour = "black"), 
        axis.text.x = element_blank(), 
        axis.text.y = element_blank()) +
  theme(plot.title = element_text(size = rel(2), colour = "blue"), 
        axis.title.y = element_text(size = rel(1.2), colour = "black")) +
  labs(list(title = "Survey Participant Programs", x = "", 
            y = "Number of Students"))

r <- ggplot(prereq, aes(x = Prereq, y = count, colour = Prereq, 
                         fill = Prereq)) +
  geom_bar(stat = "identity") +
  coord_cartesian(ylim = c(0, 4)) + 
  geom_text(data = prereq, aes(label = count,
                                y = count + 0.45), size = 6) + 
  theme(legend.background = element_rect(colour = "black"), 
        axis.text.x = element_blank(), 
        axis.text.y = element_blank()) +
  theme(plot.title = element_text(size = rel(2), colour = "blue"), 
        axis.title.y = element_text(size = rel(1.2), colour = "black")) +
  labs(list(title = "Survey Participant Stat 511 Enrollment", x = "", 
            y = "Number of Students"))

s <- ggplot(cs_course, aes(x = CS_courses, y = count, colour = CS_courses, 
                         fill = CS_courses)) +
  geom_bar(stat = "identity") +
  coord_cartesian(ylim = c(0, 6)) + 
  geom_text(data = cs_course, aes(label = count,
                                y = count + 0.45), size = 6) + 
  theme(legend.background = element_rect(colour = "black"), 
        axis.text.x = element_blank(), 
        axis.text.y = element_blank()) +
  theme(plot.title = element_text(size = rel(2), colour = "blue"), 
        axis.title.y = element_text(size = rel(1.2), colour = "black")) +
  labs(list(title = "Survey Participant CS Courses", x = "", 
            y = "Number of Students"))

t <- ggplot(languages, aes(x = Languages, y = count, colour = Languages, 
                         fill = Languages)) +
  geom_bar(stat = "identity") +
  coord_cartesian(ylim = c(0, 5)) + 
  geom_text(data = languages, aes(label = count,
                                y = count + 0.45), size = 6) + 
  theme(legend.background = element_rect(colour = "black"), 
        axis.text.x = element_blank(), 
        axis.text.y = element_blank()) +
  theme(plot.title = element_text(size = rel(2), colour = "blue"), 
        axis.title.y = element_text(size = rel(1.2), colour = "black")) +
  labs(list(title = "Survey Participant \nCS Languages", x = "", 
            y = "Number of Students"))

u <- ggplot(stat_course, aes(x = Stat_courses, y = count, colour = Stat_courses, 
                         fill = Stat_courses)) +
  geom_bar(stat = "identity") +
  coord_cartesian(ylim = c(0, 4)) + 
  geom_text(data = stat_course, aes(label = count,
                                y = count + 0.45), size = 6) + 
  theme(legend.background = element_rect(colour = "black"), 
        axis.text.x = element_blank(), 
        axis.text.y = element_blank()) +
  theme(plot.title = element_text(size = rel(2), colour = "blue"), 
        axis.title.y = element_text(size = rel(1.2), colour = "black")) +
  labs(list(title = "Survey Participant \nStat Courses", x = "", 
            y = "Number of Students"))

v <- ggplot(research, aes(x = Research_Amount, y = count, 
                          colour = Research_Amount, 
                         fill = Research_Amount)) +
  geom_bar(stat = "identity") +
  coord_cartesian(ylim = c(0, 6)) + 
  geom_text(data = research, aes(label = count,
                                y = count + 0.5), size = 6) + 
  theme(legend.background = element_rect(colour = "black"), 
        axis.text.x = element_blank(), 
        axis.text.y = element_blank()) +
  theme(plot.title = element_text(size = rel(2), colour = "blue"), 
        axis.title.y = element_text(size = rel(1.2), colour = "black")) +
  labs(list(title = "Survey Participant \nIndependent Research", x = "", 
            y = "Number of Students"))

w <- ggplot(CS_interest, aes(x = CS_Interest, y = count, colour = CS_Interest, 
                         fill = CS_Interest)) +
  geom_bar(stat = "identity") +
  coord_cartesian(ylim = c(0, 7)) + 
  geom_text(data = CS_interest, aes(label = count,
                                y = count + 0.45), size = 6) + 
  theme(legend.background = element_rect(colour = "black"), 
        axis.text.x = element_blank(), 
        axis.text.y = element_blank()) +
  theme(plot.title = element_text(size = rel(2), colour = "blue"), 
        axis.title.y = element_text(size = rel(1.2), colour = "black")) +
  labs(list(title = "Survey Participant \nCS Course Interest", x = "", 
            y = "Number of Students"))

x <- ggplot(Stat_Career, aes(x = Stat_Interest, y = count, 
                             colour = Stat_Interest, fill = Stat_Interest)) +
  geom_bar(stat = "identity") +
  coord_cartesian(ylim = c(0, 5)) + 
  geom_text(data = Stat_Career, aes(label = count,
                                y = count + 0.45), size = 6) + 
  theme(legend.background = element_rect(colour = "black"), 
        axis.text.x = element_blank(), 
        axis.text.y = element_blank()) +
  theme(plot.title = element_text(size = rel(2), colour = "blue"), 
        axis.title.y = element_text(size = rel(1.2), colour = "black")) +
  labs(list(title = "Survey Participant \nCS/Stat Career Interest", x = "", 
            y = "Number of Students"))

grid.arrange(p, q, nrow = 1)
grid.arrange(r, s, nrow = 1)
grid.arrange(t, u, nrow = 1)
grid.arrange(v, w, x, nrow = 2)
