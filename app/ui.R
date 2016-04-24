library(shiny)

shinyUI(fluidPage(
    
    headerPanel("Data Science Capstone - Predict the next word"),
    
    navlistPanel(
        
        
        tabPanel("Information",
                 
                 h3("When born the necessary to do that?"),
                 
                 p("This app was developed to pass the Data Science capstone of John Hopkins University, 
                   the challenge is build a model to predict in base about what are you writing what 
                   should be the next word, to do that the builder has to have data science skills 
                   or related study fields, This Specialization covers the concepts and tools you'll need throughout 
                   the entire data science pipeline, from asking the right kinds of questions to making inferences 
                   and publishing results. In the final Capstone Project, you’ll apply the skills learned by building a
                   data product using real-world data. At completion, students will have a portfolio demonstrating their 
                   mastery of the material."),
                 
                 h3("Challenge:"),
                 
                 p("Around the world, people are spending an increasing amount of time on their mobile devices for email,
                   social networking, banking and a whole range of other activities. But typing on mobile devices can
                   be a serious pain. SwiftKey, our corporate partner in this capstone, builds a smart keyboard that
                   makes it easier for people to type on their mobile devices. One cornerstone of their smart 
                   keyboard is predictive text models. When someone types:"),
                 
                 h3("NLP"),
                 
                 p("NLP covers a broad range of topics in natural language processing, including word and sentence 
                   tokenization, text classification and sentiment analysis, spelling correction, information extraction, 
                   parsing, meaning extraction, and question answering, We will also introduce the underlying theory 
                   from probability, statistics, and machine learning that are crucial for the field, and cover fundamental
                   algorithms like n-gram language modeling, naive bayes and maxent classifiers, sequence models 
                   like Hidden Markov Models, probabilistic dependency and constituent parsing, and vector-space 
                   models of meaning."),
                 
                 h3("Ngrams"),
                 
                 p('An n-gram model is a type of probabilistic language model for predicting the next item in such a
                    sequence in the form of a (n − 1)–order Markov model.[2] n-gram models are now widely used in 
                    probability, communication theory, computational linguistics (for instance, statistical natural 
                    language processing), computational biology (for instance, biological sequence analysis), and data 
                    compression. Two benefits of n-gram models (and algorithms that use them) are simplicity and 
                    scalability – with larger n, a model can store more context with a well-understood space–time 
                    tradeoff, enabling small experiments to scale up efficiently.'),
                 
                 
                 tags$img(src="http://brand.jhu.edu/content/uploads/2014/06/university.logo_.small_.horizontal.blue_.jpg", width = "500px", height = "200px")
                 
                 
        ),
        
        tabPanel("How does it work?",
              
                 h3("Instructions:"),  
                 
                 p('The functionality of this App is very easy and very helpful. sometimes when you are writing
                   and you forget the context about you are writing, this app can be help you. otherwise if you arent 
                   a native english writter, you can forget how write a specifict word, if it is your case no worries,
                   predicted words App is your solution. ;)'),
                 
                 h3("Steps:"),
                 
                 tags$ul(
                     
                     tags$li("As you should to know this is a first attemp to build a NLP application, the first task
                             about our system is load a predictive model. while the model doesn's loaded the app doesn't
                             to know what words suggested you :(. But dont worries it just takes a few secods"),
                     
                     tags$li("Wait a few seconds to that the model are completely loaded"),
                     
                     tags$img(src="https://raw.githubusercontent.com/uayeb25/predictnextword/master/loading.png",height = "70px" ),
                     
                     tags$li("When the model is loading you're going to see the next message"),
                     
                     tags$img(src="https://raw.githubusercontent.com/uayeb25/predictnextword/master/ready.png",height = "70px"),
                     
                     tags$li("After that you will be able to write on our magic textbox"),
                     
                     tags$img(src="https://raw.githubusercontent.com/uayeb25/predictnextword/master/textbox.png",height = "70px")
                     
                     
                     
                 )
                 
        ),
        
        tabPanel("App",
                 
                 h3("What are you thinking now? please write it on the textbox!"),
                 textInput("txtPredict",""),
                 
                 "Wait the message to start: ",
                 verbatimTextOutput("oid1"),
                 
                 h3("Preditected words:"),
                 tags$h3(uiOutput("predictions", inline = TRUE))
                 
        )
        
        
        
        
    )
))