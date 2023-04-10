:- use_module(library(pce)).

main :- 
    new(D, dialog('Trivia')),
    send(D, size, size(600, 600)),
    send(D, open),
    starting_graphics(D).

   
starting_graphics(D) :-
    send(D, append, new(EndButton, button('End Game', message(D, destroy)))),
    send(EndButton, center, point(300, 550)),

    send(D, append, new(TitleText, text('Welcome To The World Trivia Quiz!', center))),
    send(TitleText, center, point(300, 25)),
    send(TitleText, font, font(helvetica, normal, 16)),

    send(D, append, new(CategoryText, text('Please Choose a Category!', center))),
    send(CategoryText, center, point(300, 65)),
    send(CategoryText, font, font(helvetica, normal, 12)),

    send(D, append, new(Games, button('Video Games'))),
    send(Games, center, point(150, 120)),
    send(Games, size, size(400,100)),

    send(D, append, new(PopCulture, button('Pop Culture'))),
    send(PopCulture, center, point(150, 240)),
    send(PopCulture, size, size(400,100)),

    send(D, append, new(Geography, button('Geography'))),
    send(Geography, center, point(150, 360)),
    send(Geography, size, size(400,100)),

    send(Games, message, message(@prolog, games_clicked, D, TitleText, CategoryText, Games, PopCulture, Geography)),
    send(PopCulture, message, message(@prolog, pop_clicked, D, TitleText, CategoryText, Games, PopCulture, Geography)),
    send(Geography, message, message(@prolog, geo_clicked, D, TitleText, CategoryText, Games, PopCulture, Geography)).



games_clicked(D, TitleText, CategoryText, Games, PopCulture, Geography) :-
    video_game_questions(Questions),
    random_member(Question, Questions),
    Question = (QuestionText, Choices, CorrectIndex),
    writeln(QuestionText),

    send(TitleText, string, QuestionText),
    send(CategoryText, string, 'Choose the Correct Answer.'),

    Choices = [Choice1, Choice2, Choice3],

    send(Games, label, Choice1),
    send(Games, message, message(@prolog, check_answer, D, CorrectIndex, 1, CategoryText)),

    send(PopCulture, label, Choice2),
    send(PopCulture, message, message(@prolog, check_answer, D, CorrectIndex, 2, D, CategoryText)),

    send(Geography, label, Choice3),
    send(Geography, message, message(@prolog, check_answer, D, CorrectIndex, 3, D, CategoryText)).



pop_clicked(D, TitleText, CategoryText, Games, PopCulture, Geography) :-
    pop_culture_questions(Questions),
    random_member(Question, Questions),
    Question = (QuestionText, Choices, CorrectIndex),

    send(TitleText, string, QuestionText),
    send(CategoryText, string, 'Choose the Correct Answer.'),

    Choices = [Choice1, Choice2, Choice3],

    send(Games, label, Choice1),
    send(Games, message, message(@prolog, check_answer, D, CorrectIndex, 1, CategoryText)),

    send(PopCulture, label, Choice2),
    send(PopCulture, message, message(@prolog, check_answer, D, CorrectIndex, 2, CategoryText)),

    send(Geography, label, Choice3),
    send(Geography, message, message(@prolog, check_answer, D, CorrectIndex, 3, CategoryText)).

geo_clicked(D, TitleText, CategoryText, Games, PopCulture, Geography) :-
    geography_questions(Questions),
    random_member(Question, Questions),
    Question = question(QuestionText, Choices, CorrectIndex),

    send(TitleText, string, QuestionText),
    send(CategoryText, string, 'Choose the Correct Answer.'),

    Choices = [Choice1, Choice2, Choice3],

    send(Games, label, Choice1),
    send(Games, message, message(@prolog, check_answer, D, CorrectIndex, 1, CategoryText)),

    send(PopCulture, label, Choice2),
    send(PopCulture, message, message(@prolog, check_answer, D, CorrectIndex, 2, CategoryText)),

    send(Geography, label, Choice3),
    send(Geography, message, message(@prolog, check_answer, D, CorrectIndex, 3, CategoryText)).


check_answer(D, CorrectIndex, ChosenIndex, CategoryText) :-
    (   CorrectIndex = ChosenIndex
    ->  send(CategoryText, string, 'Correct!')
    ;   send(CategoryText, string, 'Incorrect!')
    ),
    % Reset the game after a brief pause
    sleep(2),
    send(D, destroy),
    main.



video_game_questions([
    ('Who is the main protagonist in the "Legend of Zelda" series?', ["Ganondorf", "Zelda", "Link"], 2),
    ('What is the highest-selling video game of all time?', ["Minecraft", "Wii Sports", "Grand Theft Auto V"], 1),
    ('Who is the main character in the "Final Fantasy VII" game?', ["Zidane Tribal", "Cloud Strife", "Tidus"], 2),
    ('Who is the main character in the "Devil May Cry" series?', ["Vergil", "Nero", "Dante"], 3),
    ('Who is the main character in the "Max Payne" series?', ["Mona Sax", "Alex Balder", "Max Payne"], 3),
    ('Who is the main character in the "Half-Life" series?', ["Gordon Freeman", "Alyx Vance", "Dr. Wallace Breen"], 1),
    ('Who is the main character in the "Red Dead Redemption" series?', ["John Marston", "Arthur Morgan", "Dutch van der Linde"], 2),
    ('What material is used to make a Nether Portal in Minecraft?', ["Obsidian", "Netherrack", "Soul Sand"], 1)
]).

pop_culture_questions([
    ('Who played the character of Luke Skywalker in the original "Star Wars" trilogy?', ["Mark Hamill", "Harrison Ford", "Carrie Fisher"], 1),
    ('What is the name of the lead singer of the band Coldplay?', ["Chris Martin", "Guy Berryman", "Jonny Buckland"], 1),
    ('What is the name of the fictional city where Batman operates in the DC Comics universe?', ["Metropolis", "Gotham City", "Central City"], 2),
    ('What is the name of the high school where "Beverly Hills, 90210" takes place?', ["West Beverly High School", "Beverly Hills High School", "Hollywood High School"], 2),
    ('What is the name of the main character in the "Harry Potter" book series?', ["Hermione Granger", "Ron Weasley", "Harry Potter"], 3),
    ('What is the name of the fictional African country that Black Panther is from in the Marvel Comics universe?', ["Wakanda", "Zamunda", "Genosha"], 1),
    ('Who played the character of Walter White in the TV series "Breaking Bad"?', ["Bryan Cranston", "Aaron Paul", "Giancarlo Esposito"], 1),
    ('What is the name of the fictional town where "Stranger Things" takes place?', ["Hawkins", "Derry", "Westeros"], 1),
    ('Who is the lead actress in the TV series "Friends"?', ["Jennifer Aniston", "Courteney Cox", "Lisa Kudrow"], 1),
    ('What is the name of the fictional continent where the TV series "Game of Thrones" takes place?', ["Essos", "Westeros", "Sothoryos"], 2)
]).

geography_questions([
    ('What is the capital of Brazil?', ["São Paulo", "Rio de Janeiro", "Brasília"], 3),
    ('What is the largest country by land area in the world?', ["Russia", "China", "Canada"], 1),
    ('What is the largest continent in the world?', ["Asia", "Africa", "North America"], 1),
    ('What is the name of the highest mountain in Africa?', ["Mount Everest", "Kilimanjaro", "Denali"], 2),
    ('What is the capital of Japan?', ["Kyoto", "Osaka", "Tokyo"], 3),
    ('What is the longest river in South America?', ["Amazon River", "Orinoco River", "Paraná River"], 1),
    ('What is the smallest country by land area in the world?', ["Monaco", "San Marino", "Vatican City"], 3),
    ('What is the name of the largest desert in the world?', ["Gobi Desert", "Sahara Desert", "Arabian Desert"], 2),
    ('What is the name of the strait that separates Asia and North America?', ["Bering Strait", "Strait of Hormuz", "Strait of Malacca"], 1),
    ('What is the capital of Australia?', ["Sydney", "Melbourne", "Canberra"], 3)
]).


    