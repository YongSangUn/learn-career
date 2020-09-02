from survey import AnonymousSurvey

question = "What language did you first learn to speak?"
my_survey = AnonymousSurvey(question)
my_survey.show_question()

while True:
    response = input("Language: ")
    if response == "q":
        break
    my_survey.store_response(response)

my_survey.show_results()