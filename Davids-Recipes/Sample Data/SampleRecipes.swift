//
//  SeedData.swift
//  Davids-Recipes
//
//  Created by David Murdock on 12/3/24.
//

import Foundation

// Used for Seeding the database, initially
let sampleRecipes = [
    Recipe(
        title: "Cool Strawberry Slush",
        imageUrl: "https://thatgirlcookshealthy.com/wp-content/uploads/2014/05/frozen-strawberry-slushie.jpg",
        author: "Bea Stewart",
        quote: "> \"A perfect summer heat relief!\"",
        categories: ["Beverages"],
        ingredients: """
        |   Quantity    |   Description |   Notes   |
        |-----|-----|-----|
        |   2 cups  |    Strawberries    |   If frozen, thaw |
        |   1 cup |   Sugar    |      |
        |   1 can (12 oz.) |   Pink Lemonade    |   Concentrate, thawed   |
        |   5 cans |   Water    |      |
        |        |   Fresh Fruit Chunks    |   Optional   |
        |        |   Lemon-Lime soda    |      |
        """,
        instructions: """
        1. Mash strawberries with a potato masher. 
        2. Combine mashed strawberries, lemonade, sugar and water in a large bowl. 
        3. Mix well. 
        4. Pour into a container such as a plastic ice cream bucket. 
        5. Freeze. (I used ice cube trays). 
        6. To serve, let thaw about one hour. 
        7. Place a scoop of the slush into each glass and pour lemon-lime soda all over the mixture. 
        8. Thread chunks of fruit on a skewer to make a kabob and use to stir the slush.
        """,
        notes: """
        I think there was a typo in the original recipe that said "lemon-line"
        """,
        isFavorite: true,
        lastModified: Date()
    ),
    Recipe(
        title: "Hot Apple Cider",
        imageUrl: "https://www.allrecipes.com/thmb/mrWjvbSfj0npL8_26Svhx33wgjE=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/9501-hot-apple-cider-DDMFS-4x3-262c1362f2514c998fd61ff9dff61350.jpg",
        author: "Grandma McCleve",
        quote: "> \"This recipe was written in a little spiral index book that Grandma had done. It had some of her favorite recipes in there.\"",
        categories: ["Beverages"],
        ingredients: """
        |   Quantity    |   Description |   Notes   |
        |-----|-----|-----|
        |    4 cups    |    Apple Juice    |        |
        |    3 sticks    |    Cinnamon    |        |
        |    2 cups    |    Apple Cider    |        |
        """,
        instructions: """
        1. Break cinnamon into small pieces
        2. Heat apple juice and cider and cinnamon
        3. Serve hot
        4. Add sugar if desired
        """,
        notes: """
        Seems good, but you need apple cider mix to make this apple cider, haha
        """,
        isFavorite: false,
        lastModified: Date()
    ),
    Recipe(
        title: "French Toast",
        imageUrl: "https://sugarspunrun.com/wp-content/uploads/2023/08/French-Toast-recipe-1-of-1.jpg",
        author: "Jennifer Murdock",
        quote: "> \"My dad, Fred Stewart, used to make these in the mornings and they are so yummy.\"",
        categories: ["Breakfast"],
        ingredients: """
        |   Quantity    |   Description |   Notes   |
        |-----|-----|-----|
        |    2    |    Eggs    |    For each serving    |
        |    1/2 cup    |    Milk    |    For each serving    |
        """,
        instructions: """
        1. Beat. For every 2 eggs, you put in 1/2 cup of milk.
        2. Then pour it in a cake or pie tin, and dip both sides of a piece of bread. 
        3. Then cook on hot greased skillet or pan and cook until brown.
        """,
        notes: """
        I love french toast
        """,
        isFavorite: false,
        lastModified: Date()
    ),
    Recipe(
        title: "Fluffy Pancakes",
        imageUrl: "https://www.allrecipes.com/thmb/hB7uGW06pqyk6hApOfGxk5kG4SI=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/21014-Good-old-Fashioned-Pancakes-mfs_001-1-8fc3e06998fe4fe8b5f2ad6ba7e8ad46.jpg",
        author: "Emily McCleve",
        quote: "> \"These are my favorite recipes that I got in my FACS class. I sure had fun learning to be a good cook in the class.\"",
        categories: ["Breakfast"],
        ingredients: """
        |   Quantity    |   Description |   Notes   |
        |-----|-----|-----|
        |    2    |    Eggs    |    Separated    |
        |    2 cups    |    Milk    |        |
        |    1 tsp.    |    Salt    |        |
        |    4 tbsp.    |    Oil    |        |
        |    2 cups    |    Flour    |        |
        |    4 tsp.    |    Baking Powder    |        |
        """,
        instructions: """
        1. Beat egg whites in a clean glass bowl with an electric beater, until fluffy and stiff. 
        2. In a large bowl, blend all the other ingreidents plus the egg yolk, with the electric mixer. 
        3. Add the fluffy white to the large bowl, mixing with the electric mixer. 
        4. Heat griddle to medium heat. 
        5. Pour some batter on the griddle. 
        5. Is it done? Watch for bubbles popping on top. 
        6. Also watch for a firm edge. 
        7. Take a peek to check the golden color underneath. 
        8. Use a wide, plastic spatula. 
        9. Flip it over. 
        10. Both sides should be golden brown. 
        11. Top with butter and syrup or applesauce and cinnamon and sugar.
        """,
        notes: """
        Oooh, these seem nice!
        """,
        isFavorite: false,
        lastModified: Date()
    ),
    Recipe(
        title: "Quick Pizzas",
        imageUrl: "https://www.eatingbirdfood.com/wp-content/uploads/2021/09/tortilla-pizzas-overhead.jpg",
        author: "Kimberly Johnston",
        quote: "> \"Luke loves pizza\"",
        categories: ["Lunch"],
        ingredients: """
        |   Quantity    |   Description |   Notes   |
        |-----|-----|-----|
        |    6    |    Flour Tortillas    |        |
        |    8 oz.    |    Colby Jack    |    Grated    |
        |    1/2 cup    |    Chopped Onion    |        |
        |    2 cans    |    Tomato Sauce    |        |
        |    1lb.    |    Ground Beef    |    Or Ground Turkey (browned)    |
        """,
        instructions: """
        1. Place tortillas on a cookie sheet and top tortillas with tomato sauce, ground beef, onion, and cheese. You can use any other toppings you like
        2. Bake in oven at 350 degrees Farenheit for 5-10 minutes or until golden brown or until cheese is melted
        """,
        notes: """
        Note: if you like pork sausage, you can use that in place of the ground beef. Our family prefers this over the beef or the turkey. You can use any other toppings you like.
        """,
        isFavorite: false,
        lastModified: Date()
    ),
    Recipe(
        title: "Campbell's Baked Mac 'n' Cheese ",
        imageUrl: "https://www.spendwithpennies.com/wp-content/uploads/2022/12/Baked-Mac-and-Cheese-SpendWithPennies-35.jpg",
        author: "Lashelle Maner",
        quote: "> \"I don't like Macaroni and Cheeese, but I do like this\"",
        categories: ["Lunch"],
        ingredients: """
        |   Quantity    |   Description |   Notes   |
        |-----|-----|-----|
        |    1 can    |    Condensed Cheddar Cheese Soup    |        |
        |    1/8 tsp.    |    Pepper    |        |
        |    1 tbsp.    |    Dry Bread Crumbs    |        |
        |    2/3 cup    |    Milk    |        |
        |    2 cups    |    Hot Cooked Corkscrew Macaroni    |        |
        |    1 tsp.    |    Margarine    |    Melted    |
        """,
        instructions: """
        1. In 1 quart of casserole, mix soup, milk, pepper, and macaroni.
        2. Sprinkle Bread Crumbs mixed with margarine over top
        3. Bake at 400 degrees for 20 minutes or until hot
        4. Serves 2 main dish or 4 side dish
        """,
        notes: """
        
        """,
        isFavorite: true,
        lastModified: Date()
    ),
    Recipe(
        title: "Chicken Parmesan",
        imageUrl: "https://tastesbetterfromscratch.com/wp-content/uploads/2023/03/Chicken-Parmesan-1.jpg",
        author: "Lashelle Maner",
        quote: "> \"Aunt Sherlene submitted this recipe in the first McCleve cookbook\"",
        categories: ["Dinner"],
        ingredients: """
        |   Quantity    |   Description |   Notes   |
        |-----|-----|-----|
        |    2 1/2 cups    |    Bread Crumbs    |    Dried    |
        |    1/8 cup    |    Parsley Flakes    |    Optional, it adds color    |
        |    1    |    Full Chicken's Worth of Chicken    |        |
        |    1/2 cup    |    Grated Parmesan Cheese    |        |
        |    1 1/2 tbsp.    |    Seasoned Salt    |        |
        """,
        instructions: """
        1. Cut up the chicken into whatever size you want
        2. Melt enough butter for dipping chicken
        3. Dip chicken in butter and then in bread crumbs mixture
        4. Place on baking sheet and bake for 1 hour at 350 degrees
        """,
        notes: """
        When I make this, I use frozen chicken breast (thawed). If I have leftovers, I like to cut the chicken in pieces and make a sandwich. Or it is also good on top of a green salad. Aunt Sherlene submitted this recipe in the first McCleve cookbook.
        """,
        isFavorite: true,
        lastModified: Date()
    ),
    Recipe(
        title: "Sweet and Sour Chicken",
        imageUrl: "https://www.swankyrecipes.com/wp-content/uploads/2022/05/Best-Sweet-and-Sour-Chicken.jpg",
        author: "Bea Stewart",
        quote: "> \"This was a recipe that my mom got many years ago at homemakeing. It was one of my favorite things growing up. Still one of my most favorite things now that I am grown up. I guess I am grown up.\"",
        categories: ["Dinner"],
        ingredients: """
        #### Sauce:
        |   Quantity    |   Description |   Notes   |
        |-----|-----|-----|
        |    3/4 cup    |    Sugar    |        |
        |    1/2    |    Chicken Stock    |        |
        |    1 tbsp.    |    Soy Sauce    |        |
        |    1/2 cup    |    Vinegar    |        |
        |    4 tbsp.    |    Catsup    |        |
        |    1 tsp.    |    Garlic Salt    |        |
        """,
        instructions: """
        1. Mix above ingredients over medium heat
        2. Take about 3 lbs of cut up chicken breast and sprinkle with garlic salt
        3. Then dip the chicken into corn starch then beaten egg the corn starch
        4. Brown in oil until golden brown
        5. Place in 9 x 12 cake pan and pour sauce over the chicken
        6. Bake for one hour in 325 degree oven. Turn occasionally
        
        #### For a quick and low fat recipe:
        1. Make the sauce as above, but mix 2 to 3 tbsp. corn starch in with the sugar and add remaining ingredients in the sauce
        2. Put the cut up chicken in the pan and pour sauce over and bake the very same
        3. Serve over rice
        """,
        notes: """
        Note: pineapple chunks, carrots, green peppers, onion, broccoli may be added.
        """,
        isFavorite: false,
        lastModified: Date()
    ),
    Recipe(
        title: "Cherry Cheesecake",
        imageUrl: "https://thatovenfeelin.com/wp-content/uploads/2023/11/CHERRY-CHEESECAKE-3.png",
        author: "Melanie Egbert",
        quote: "> \"We had this at Brian's missionary homecoming potluck made by the Eyres\"",
        categories: ["Dessert"],
        ingredients: """
        |   Quantity    |   Description |   Notes   |
        |-----|-----|-----|
        |    8 oz.    |    Cream Cheese    |    Softened    |
        |    1/3 cup    |    Lemon Juice    |        |
        |    1 can (14 oz.)    |    Sweetened Condensed Milk    |        |
        |    1 tsp.    |    Vanilla    |        |
        """,
        instructions: """
        1. Mix together and pour into graham cracker crust (you can make your own or buy them)
        2. Chill and then top with cherry pie filling (chilled)
        3. The longer you are able to chill it, the better it sets up
        """,
        notes: """
        
        """,
        isFavorite: true,
        lastModified: Date()
    ),
    Recipe(
        title: "Crepes",
        imageUrl: "https://plus.unsplash.com/premium_photo-1707757442378-8cb5223916ae?q=80&w=2944&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
        author: "Bea Stewart",
        quote: "> \"Peaches and creme are our favorite, here\"",
        categories: ["Breakfast","Dessert"],
        ingredients: """
        |   Quantity    |   Description |   Notes   |
        |-----|-----|-----|
        |    1 1/2 cup    |    Milk    |        |
        |    2    |    Eggs    |        |
        |    1/4 tsp.    |    Salt    |        |
        |    1 cup    |    Flour    |        |
        |    1 tbsp.    |    Oil    |        |
        """,
        instructions: """
        1. Spray a non-stick small skillet and get hot
        2. Put in about 2 to 3 tbsp. spoon batter and move the pan around in a circle (the thinner the better)
        3. Cook until brown on both sides
        4. Add toppings (Sweet crepes: Fill with fresh fruit, ice-cream, and chocolate syrup on top, Savory crepes: add ham, cheese, and eggs, whatever you like) 
        """,
        notes: """
        Mix together with mixer.
        Sweet Crepes: Omit salt and add 2 tbsp. sugar.
        """,
        isFavorite: true,
        lastModified: Date()
    )
]
