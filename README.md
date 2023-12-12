# Chess
Chess, played in the command line. The final project for the Ruby portion of The Odin Project.

**Rules for player input**
1. Algebraic notation MUST be used, and proper capitalization is necessary.
    - Leading letters for piece specification must be capitalized (ex. 'Kg5')
    - File notation is always lowercase (ex. 'Kg5' or 'e4')
    - When specifying file AND rank for a specific piece, file must come before rank (ex. 'Kd2g5')

**Features of the project**
1. You can save and load game files.
2. All rules of chess are available, including en passant and castling.
3. Leading letters for piece specification must be capitalized (ex. 'Kg5')

**Where I went wrong, and how to improve**
1. The variable naming I used throughout the project is an absolute mess. I should have decided on specific variable names for consistenly used variables, but once the project got going I let it get a bit out of hand. Different names are used for the same variables such as "piece", "tile", and "coordinate" when referring to the square a piece is located. This is something I would like to refactor at some point.
2. The classes are ALSO an absolute mess. It wasn't until halfway done that I realized, upon beginning the book "Practical Object-Oriented Design in Ruby - An Agile Primer" by Sandi Metz, that my classes should do ONE THING, as should my methods. I was able to somewhat refactor many of my methods and remove logic into separate methods of their own in order to reduce complexity, but my classes were already too rigid for me to comfortably refactor without essentially starting over (which I don't have the luxury to do right now - on a bit of a time crunch). The result is extremely bloated classes (Game in particular, but I could easily break out Board and Piece into smaller classes as well). I would LOVE to dive back in in the future and tear it apart to create much more focused and modular classes and methods now that I can see the project from the finish line, so hopefully I can find the time to do that.
3. I did a lot of testing, but this was also the first time I've really done serious testing of any serious program I've written. I am sure there are tests that aren't covering what I need them to cover, and as a result there are probably bugs I haven't found. I learned a ton about testing by doing this project though and when revisting in the future I would like to revisit my tests as well to see how I could improve.
4. I utilized branching, but not to the extent I would have liked. It was primarily in the back half of the project that I started getting comfortable with branching which I'm happy to have done, but I would have liked to explore it further. That being said, I don't think it was a total failure.

**Future Additions**
1. More visibly pleasing UI/graphics.
2. Much more focused classes.
3. Error messages are present, but are not always 100% accurate for the situation (even though they're not technically _wrong_, I'd just like them to be more correct/specific).
4. Play against the computer (simple AI)
5. Better testing.

**Final Thoughts**

This project took me roughly one month to complete, and is by far the most complex, dense, and fully encompassing project I've had the opportunity to work on. I was able to work through frustrations, dead-ends, testing different approaches, and feel like I really learned to _program_ by doing so. It was great to be pushed off the deep end and figure everything out by myself via trying multiple different approaches to find a solution that not just worked, but worked within the scope of what I had already built. Many times I figured out a solution to a method, only to realize it didn't realistically work with everything else I had done. So I took what I could and adapted it to create something that did what I needed it to do. I learned a lot about managing the project as a whole, the importance of slowing down, thinking long-term, creating methods and classes with single responsibilities (even though I fundamentally failed at this), and TDD (or testing along with writing, if before isn't reasonable). In the beginning, the project started to run away from me and I was extremely discouraged when I found myself on the brink of starting over because the complexity got too out of hand. I was able to salvage it and kept that in mind going forward.

Overall, this was a confidence-inspiring process that I'm thrilled to have finished, and I'm excited to move forward in my programming journey. 
