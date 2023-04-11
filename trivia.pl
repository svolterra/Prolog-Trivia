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

    send(D, append, new(ScoreText, text(''))),
    send(ScoreText, position, point(100, 50)),
    send(ScoreText, font, font(helvetica, normal, 16)),
    
    send(D, append, new(CategoryText, text('Please Choose a Category!', center))),
    send(CategoryText, center, point(300, 65)),
    send(CategoryText, font, font(helvetica, normal, 13)),

    send(D, append, new(Games, button('Video Games'))),
    format_game_button(Games),

    send(D, append, new(PopCulture, button('Pop Culture'))),
    format_pop_button(PopCulture),

    send(D, append, new(Geography, button('Geography'))),
    format_geo_button(Geography),

    send(Games, message, message(@prolog, games_clicked, D, TitleText, CategoryText, ScoreText, Games, PopCulture, Geography, 0, 0)),
    send(PopCulture, message, message(@prolog, pop_clicked, D, TitleText, CategoryText, ScoreText, Games, PopCulture, Geography, 0, 0)),
    send(Geography, message, message(@prolog, geo_clicked, D, TitleText, CategoryText, ScoreText, Games, PopCulture, Geography, 0, 0)).

%All of these are to format the buttons to the correct positions
format_game_button(Games) :-
    send(Games, position, point(120, 120)),
    send(Games, size, size(400,100)).


format_pop_button(PopCulture) :-
    send(PopCulture, position, point(120, 240)),
    send(PopCulture, size, size(400,100)).


format_geo_button(Geography) :-
    send(Geography, position, point(120, 360)),
    send(Geography, size, size(400,100)).

%Handles the game button.
games_clicked(D, TitleText, CategoryText, ScoreText, Games, PopCulture, Geography, QuestionNumber, CorrectAnswers) :-
    video_game_questions(Questions),
    nth0(QuestionNumber, Questions, Question),
    Question = (QuestionText, Choices, CorrectIndex),

    send(TitleText, string, QuestionText),
    send(CategoryText, string, 'Choose the Correct Answer.'),

    Choices = [Choice1, Choice2, Choice3],

    send(Games, label, Choice1),
    send(Games, message, message(@prolog, check_answer_games, D, TitleText, CategoryText, ScoreText, Games, PopCulture, Geography, CorrectIndex, 1, QuestionNumber, CorrectAnswers)),
    format_game_button(Games),

    send(PopCulture, label, Choice2),
    send(PopCulture, message, message(@prolog, check_answer_games, D, TitleText, CategoryText, ScoreText, Games, PopCulture, Geography, CorrectIndex, 2, QuestionNumber, CorrectAnswers)),
    format_pop_button(PopCulture),

    send(Geography, label, Choice3),
    send(Geography, message, message(@prolog, check_answer_games, D, TitleText, CategoryText, ScoreText, Games, PopCulture, Geography, CorrectIndex, 3, QuestionNumber, CorrectAnswers)),
    format_geo_button(Geography).

%Handles the popculture button
pop_clicked(D, TitleText, CategoryText, ScoreText, Games, PopCulture, Geography, QuestionNumber, CorrectAnswers) :-
    pop_culture_questions(Questions),
    nth0(QuestionNumber, Questions, Question),
    Question = (QuestionText, Choices, CorrectIndex),

    send(TitleText, string, QuestionText),
    send(CategoryText, string, 'Choose the Correct Answer.'),

    Choices = [Choice1, Choice2, Choice3],

    send(Games, label, Choice1),
    send(Games, message, message(@prolog, check_answer_pop, D, TitleText, CategoryText, ScoreText, Games, PopCulture, Geography, CorrectIndex, 1, QuestionNumber, CorrectAnswers)),
    format_game_button(Games),

    send(PopCulture, label, Choice2),
    send(PopCulture, message, message(@prolog, check_answer_pop, D, TitleText, CategoryText, ScoreText, Games, PopCulture, Geography, CorrectIndex, 2, QuestionNumber, CorrectAnswers)),
    format_pop_button(PopCulture),

    send(Geography, label, Choice3),
    send(Geography, message, message(@prolog, check_answer_pop, D, TitleText, CategoryText, ScoreText, Games, PopCulture, Geography, CorrectIndex, 3, QuestionNumber, CorrectAnswers)),
    format_geo_button(Geography).

%Handles the geography button
geo_clicked(D, TitleText, CategoryText, ScoreText, Games, PopCulture, Geography, QuestionNumber, CorrectAnswers) :-
    geography_questions(Questions),
    nth0(QuestionNumber, Questions, Question),
    Question = (QuestionText, Choices, CorrectIndex),

    send(TitleText, string, QuestionText),
    send(CategoryText, string, 'Choose the Correct Answer.'),

    Choices = [Choice1, Choice2, Choice3],

    send(Games, label, Choice1),
    send(Games, message, message(@prolog, check_answer_geo, D, TitleText, CategoryText, ScoreText, Games, PopCulture, Geography, CorrectIndex, 1, QuestionNumber, CorrectAnswers)),
    format_game_button(Games),

    send(PopCulture, label, Choice2),
    send(PopCulture, message, message(@prolog, check_answer_geo, D, TitleText, CategoryText, ScoreText, Games, PopCulture, Geography, CorrectIndex, 2, QuestionNumber, CorrectAnswers)),
    format_pop_button(PopCulture),

    send(Geography, label, Choice3),
    send(Geography, message, message(@prolog, check_answer_geo, D, TitleText, CategoryText, ScoreText, Games, PopCulture, Geography, CorrectIndex, 3, QuestionNumber, CorrectAnswers)),
    format_geo_button(Geography).


%All of these are to check the answers of the game and keep track of which question is there
check_answer_games(D, TitleText, CategoryText, ScoreText, Games, PopCulture, Geography, CorrectIndex, ChosenIndex, QuestionNumber, CorrectAnswers) :-
    (   ChosenIndex == CorrectIndex 
    ->
    NewCorrectAnswers is CorrectAnswers + 1,
    number_string(NewCorrectAnswers, S),
    send(ScoreText, string, S)
    ; NewCorrectAnswers is CorrectAnswers
    ),
    NewQuestionNumber is QuestionNumber + 1,
    (NewQuestionNumber >= 20 
    -> scoreScreen(D, TitleText, CategoryText, ScoreText, Games, PopCulture, Geography, NewCorrectAnswers)
    ; games_clicked(D, TitleText, CategoryText, ScoreText, Games, PopCulture, Geography, NewQuestionNumber, NewCorrectAnswers)
    ).

check_answer_pop(D, TitleText, CategoryText, ScoreText, Games, PopCulture, Geography, CorrectIndex, ChosenIndex, QuestionNumber, CorrectAnswers) :-
    (   ChosenIndex == CorrectIndex 
    ->
    NewCorrectAnswers is CorrectAnswers + 1,
    number_string(NewCorrectAnswers, S),
    send(ScoreText, string, S)
    ; NewCorrectAnswers is CorrectAnswers
    ),
    NewQuestionNumber is QuestionNumber + 1,
    (NewQuestionNumber >= 20 
    -> scoreScreen(D, TitleText, CategoryText, ScoreText, Games, PopCulture, Geography, NewCorrectAnswers)
    ; pop_clicked(D, TitleText, CategoryText, ScoreText, Games, PopCulture, Geography, NewQuestionNumber, NewCorrectAnswers)
    ).

check_answer_geo(D, TitleText, CategoryText, ScoreText, Games, PopCulture, Geography, CorrectIndex, ChosenIndex, QuestionNumber, CorrectAnswers) :-
    (   ChosenIndex == CorrectIndex 
    ->
    NewCorrectAnswers is CorrectAnswers + 1,
    number_string(NewCorrectAnswers, S),
    send(ScoreText, string, S)
    ; NewCorrectAnswers is CorrectAnswers
    ),
    NewQuestionNumber is QuestionNumber + 1,
    (NewQuestionNumber >= 20 
    -> scoreScreen(D, TitleText, CategoryText, ScoreText, Games, PopCulture, Geography, NewCorrectAnswers)
    ; geo_clicked(D, TitleText, CategoryText, ScoreText, Games, PopCulture, Geography, NewQuestionNumber, NewCorrectAnswers)
    ).

%When we are finished a section, we go to this screen that handles the score screen behaviour
scoreScreen(D, TitleText, CategoryText, ScoreText, Games, PopCulture, Geography, CorrectAnswers) :-
    send(Games, displayed, @off),
    send(PopCulture, displayed, @off),
    send(Geography, label, "New Game?"),
    format_geo_button(Geography),
    number_string(CorrectAnswers, S),
    writeln("hi"),
    atom_concat(S, ' / 20', scoreString),
    writeln("hi"),
    Score is scoreString,
    send(ScoreText, string, scoreString),
    send(Geography, message, message(@prolog, mainMenu, D)).


mainMenu(D) :-
    send(D, destroy),
    main.

video_game_questions([
    ('What was the first commercially successful video game?', ['Pong', 'Space Invaders', 'Tetris'], 1),
    ('What year was the Super Nintendo Entertainment\nSystem (SNES) released?', ['1990', '1991', '1992'], 2),
    ('What is the best-selling handheld gaming system to date?', ['Nintendo DS', 'Nintendo Game Boy', 'PlayStation Portable'], 3),
    ('The character Mario first appeared in which classic video game?', ['Super Mario Bros.', 'Donkey Kong', 'Mario Bros.'], 3),
    ("What video game company created the popular characters\nSonic the Hedgehog and Alex Kidd?", ['Sega', 'Nintendo', 'Atari'], 2),
    ("The characters Guybrush Threepwood, Manny Calavera, and\nBen are all part of which video game developer's library?", ['LucasArts', 'Sierra', 'Capcom'], 1),
    ('Which video game series features cities called Vice City,\nSan Andreas, and Liberty City?', ['Grand Theft Auto', 'Saints Row', 'The Getaway'], 2),
    ('What popular gaming franchise features a\ntalking tree named Deku Tree?', ['Zelda', 'Final Fantasy', 'EarthBound'], 3),
    ('What is the name of the alien species in the Halo series?', ['Elites', 'Covenant', 'Forerunners'], 1),
    ('What is the name of the virtual currency used in\nthe game World of Warcraft?', ['Gold', 'Gil', 'Credits'], 2),
    ('In what year was the original "Metal Gear" game released?', ['1987', '1990', '1993'], 2),
    ('Which racing game series includes tracks named\n"Rainbow Road" and "Luigi Circuit"?', ['Mario Kart', 'Gran Turismo', 'Forza Horizon'], 1),
    ('What is the name of the protagonist in "Half-Life"?', ['Gordon Freeman', 'Alex Vance', 'Barney Calhoun'], 1),
    ('Which video game franchise features characters named\nTiny Kong, Diddy Kong, and Donkey Kong?', ['Donkey Kong', 'Banjo-Kazooie', 'Sonic the Hedgehog'], 1),
    ('What is the name of the computer system that serves as\nthe primary antagonist in the "Halo" series?', ['Cortana', 'Sentinels', 'The Gravemind'], 3),
    ('In what year was the original "Resident Evil" game released?', ['1992', '1996', '2000'], 2),
    ('Which game in the "Final Fantasy" series features\na protagonist named Lightning?', ['Final Fantasy XIII', 'Final Fantasy XV', 'Final Fantasy VII'], 1),
    ('What is the name of the protagonist in the "Assassin\'s Creed" series?', ['Altair', 'Ezio Auditore', 'Connor Kenway'], 3),
    ('What is the name of the main villain in the "Legend of Zelda" series?', ['Ganondorf', 'Zant', 'Vaati'], 1),
    ('Which game in the "Metal Gear Solid" series features\na protagonist named Raiden?', ['Metal Gear Solid 2: Sons of Liberty', 'Metal Gear Solid 3: Snake Eater', 'Metal Gear Solid 4: Guns of the Patriots'], 1)
]).

pop_culture_questions([
	('What TV series features a character named Walter White who\nstarts making and selling methamphetamine?', ['The Walking Dead', 'Breaking Bad', 'Lost'], 2),
	('What 2010 movie features Leonardo DiCaprio,\nKen Watanabe, and Ellen Page?', ['The Departed', 'Shutter Island', 'Inception'], 3),
	('What TV series features a group of friends\nincluding Rachel, Ross, and Chandler?', ['Seinfeld', 'Friends', 'The Office'], 2),
	('Which artist released the hit single "Hello" in 2015?', ['Taylor Swift', 'Adele', 'Beyonce'], 2),
	('What 1980 movie features a group of high school \n students serving Saturday detention?', ['The Breakfast Club', 'Sixteen Candles', 'Ferris Bueller\'s Day Off'], 1),
	('Which actor played the character of "Indiana Jones"\nin the "Indiana Jones" film series?', ['Tom Hanks', 'Sylvester Stallone', 'Harrison Ford'], 3),
	('What movie features a group of rebels trying\nto destroy the Death Star?', ['Star Wars: The Empire Strikes Back', 'Star Wars: A New Hope', 'Star Wars: Return of the Jedi'], 2),
	('Which artist released the hit single "Uptown Funk" in 2014?', ['Ed Sheeran', 'Mark Ronson ft. Bruno Mars', 'Maroon 5'], 2),
	('What TV series features a character named Dexter who is a blood\nspatter analyst by day and a serial killer by night?', ['Breaking Bad', 'Dexter', 'Game of Thrones'], 2),
	('What movie features the character of "Marty McFly"\ntraveling through time in a DeLorean?', ['The Terminator', 'Blade Runner', 'Back to the Future'], 3),
	('Which artist released the hit single "Smooth" in 1999?', ['OutKast', 'Santana ft. Rob Thomas', 'The Black Eyed Peas'], 2),
	('What 2014 movie features Chris Pratt and Zoe Saldana?', ['Thor: Ragnarok', 'Guardians of the Galaxy', 'The Avengers'], 2),
	('What TV series features a character named Jon Snow\nwho is part of the Night\'s Watch?', ['Stranger Things', 'Game of Thrones', 'The Walking Dead'], 2),
	('Which artist released the hit single "Billie Jean" in 1983?', ['Prince', 'Whitney Houston', 'Michael Jackson'], 3),
	('What 1984 movie features Bill Murray,\nDan Aykroyd, and Harold Ramis?', ['Caddyshack', 'Stripes', 'Ghostbusters'], 3),
	('What TV series features a group of people stranded\non an island after a plane crash?', ['Breaking Bad', 'The Office', 'Lost'], 3),
	('Which artist released the hit single "Shape of You" in 2017?', ['Justin Bieber', 'Ed Sheeran', 'Drake'], 2),
	('What movie features a group of superheroes including\nIron Man, Captain America, and Thor?', ['Justice League', 'X-Men', 'The Avengers'], 3),
	('What TV series features a character named Michael Scott \n who is the regional manager of a paper company?', ['Seinfeld', 'The Office', 'Friends'], 2),
	('Which artist released the hit single\n"I Will Always Love You" in 1992?', ['Mariah Carey', 'Whitney Houston', 'Celine Dion'], 2)
]).

geography_questions([
    ('What is the largest country in South America?', ['Brazil', 'Argentina', 'Peru'], 1),
    ('What is the smallest country in the world by land area?', ['Monaco', 'Vatican City', 'Maldives'], 2),
    ('What is the capital of New Zealand?', ['Auckland', 'Wellington', 'Christchurch'], 2),
    ('What is the largest country in Africa?', ['Nigeria', 'Egypt', 'Algeria'], 3),
    ('What is the smallest continent by land area?', ['South America', 'Africa', 'Australia'], 3),
    ('What is the highest mountain in Africa?', ['Mount Kilimanjaro', 'Mount Kenya', 'Mount Meru'], 1),
    ('What is the official language of Brazil?', ['Portuguese', 'Spanish', 'English'], 1),
    ('What is the only country to border both the Atlantic and Pacific oceans?', ['United States', 'Canada', 'Chile'], 3),
    ('What is the capital of Sweden?', ['Stockholm', 'Gothenburg', 'Malmö'], 1),
    ('What is the world\'s largest landlocked country?', ['Mongolia', 'Kazakhstan', 'Turkmenistan'], 2),
    ('What is the highest point in North America?', ['Mount Everest', 'Denali (Mount McKinley)', 'Mount Logan'], 2),
    ('What is the capital of Iran?', ['Tehran', 'Tabriz', 'Mashhad'], 1),
    ('What is the world\'s longest river?', ['Nile', 'Amazon', 'Yangtze'], 1),
    ('What is the capital of Morocco?', ['Rabat', 'Casablanca', 'Marrakesh'], 1),
    ('What is the largest island in the Mediterranean Sea?', ['Sicily', 'Sardinia', 'Cyprus'], 2),
    ('What is the smallest country in Asia?', ['Maldives', 'Bahrain', 'Singapore'], 1),
    ('What is the highest mountain in North America?', ['Mount Everest', 'Denali (Mount McKinley)', 'Mount Logan'], 2),
    ('What is the world\'s largest country by land area?', ['Russia', 'Canada', 'China'], 1),
    ('What is the capital of Egypt?', ['Cairo', 'Alexandria', 'Giza'], 1),
    ('What is the deepest point in the world\'s oceans?', ['Mariana Trench', 'Puerto Rico Trench', 'Java Trench'], 1)
]).

