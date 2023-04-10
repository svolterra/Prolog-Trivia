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
    send(Games, message, message(@prolog, game_trivia, D)),

    send(D, append, new(PopCulture, button('Pop Culture'))),
    send(PopCulture, center, point(150, 240)),
    send(PopCulture, size, size(400,100)),

    send(D, append, new(Geography, button('Geography'))),
    send(Geography, center, point(150, 360)),
    send(Geography, size, size(400,100)),

    send(Games, message, message(@prolog, pop_clicked, D, TitleText, CategoryText, Games, PopCulture, Geography)),
    send(PopCulture, message, message(@prolog, pop_clicked, D, TitleText, CategoryText, Games, PopCulture, Geography)),
    send(Geography, message, message(@prolog, geo_clicked, D, TitleText, CategoryText, Games, PopCulture, Geography)).


games_clicked(TitleText, CategoryText, Games, PopCulture, Geography) :-
    send(TitleText, string, 'What Company Developed The Last of Us?'),
    send(CategoryText, string, 'Choose the Correct Answer.'),
    
    send(Games, label, 'Clicked'),
    send(Games, center, point(150, 120)),
    send(Games, size, size(400,100)),

    send(PopCulture, label, 'Clicked'), 
    send(PopCulture, center, point(150, 240)),
    send(PopCulture, size, size(400,100)),
    
    send(Geography, label, 'Clicked'),
    send(Geography, center, point(150, 360)),
    send(Geography, size, size(400,100)).


pop_clicked(D, TitleText, CategoryText, Games, PopCulture, Geography) :-
    send(TitleText, string, 'Where is Justin Bieber From?'),
    send(CategoryText, string, 'Choose the Correct Answer.'),

    send(Games, label, 'Clicked'),
    send(Games, center, point(150, 120)),
    send(Games, size, size(400,100)),

    send(PopCulture, label, 'Clicked'), 
    send(PopCulture, center, point(150, 240)),
    send(PopCulture, size, size(400,100)),
    
    send(Geography, label, 'Clicked'),
    send(Geography, center, point(150, 360)),
    send(Geography, size, size(400,100)).

geo_clicked(TitleText, CategoryText, Games, PopCulture, Geography) :-
    send(TitleText, string, 'Where is Europe?'),
    send(CategoryText, string, 'Choose the Correct Answer.'),

    send(Games, label, 'Clicked'),
    send(Games, center, point(150, 120)),
    send(Games, size, size(400,100)),

    send(PopCulture, label, 'Clicked'), 
    send(PopCulture, center, point(150, 240)),
    send(PopCulture, size, size(400,100)),
    
    send(Geography, label, 'Clicked'),
    send(Geography, center, point(150, 360)),
    send(Geography, size, size(400,100)).

    

    