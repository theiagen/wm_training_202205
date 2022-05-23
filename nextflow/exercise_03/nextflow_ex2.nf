#!/usr/bin/env nextflow
nextflow.enable.dsl = 2

/*
In this example we're going to mix Channels and Processes, but also highlight the FIFO nature
of Channels. Meaning sometimes you don't get the order you expect.
*/

// Create a channel of colored squares
my_square_ch = Channel.from( "red-square", "blue-square", "green-square" )

// Create a channel of 3 random numbers
my_sleep_ch = Channel.from( 1..10 ).randomSample( 3 )

// A Process to convert squares to triangles
process make_triangle {

    // Tag directive prints a string for the process
    tag "${square} - ${sleep_time}"

    // Take two inputs, the square and a sleep time (random number)
    input:
    val square
    val sleep_time
    
    // Capture the STDOUT and emit it to a triangle output 
    output:
    stdout emit: triangle

    // Replace square with triangle, and sleep for a random amount of time
    script:
    """
    echo $square | sed 's/square/triangle/' | tr -d '\n'
    sleep $sleep_time 
    """
}

// Group the squares and triangles
process merge_shapes {

    // Take in an input square and triangle
    input:
    val square
    val triangle
    
    // Capture STDOUT and store it in merged
    output:
    stdout emit: merged

    // echo and square and triangle
    script:
    """
    echo $square - $triangle | tr -d '\n'
    """
}

workflow {
    // The expectation is squares and triangles will be grouped by color
    make_triangle(my_square_ch, my_sleep_ch)
    merge_shapes(my_square_ch, make_triangle.out.triangle)
    merge_shapes.out.merged.view()

    // Sometimes they are, but sometimes they are not.
}
