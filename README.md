# Shiny Module Pipelines

As a big fan of the functional approach to programming, many times I have
struggled to find an elegant solution to complex Shiny apps where data
manipulation from multiple sources is necessary. Today, while trying some
stuff, I found a little way of organizing Shiny Modules in such a way that
a pipeline of complex manipulations can be built.

This is my first attemp at this. I am not sure what the limitations or possible
best practices for such a way of writing Shiny Apps could be, but here is what
I have come up with. I would love to hear back from the community with opinions
or possibly contributions.

## The approach

When dealing with modules, purpose is really important. For this to work, a
module must return only a reactive that is update only by inputs and reactives
inside the module's server logic. It is best for the module to do one thing and
thing only so that its output can be piped into the next module.

```R
# This is in the server.R
global_data <- initial_data() %>>%
  apply_filter(id = "phase1") %>>%
  apply_filter(id = "phase2") %>>%
  apply_filter(id = "phase3")
```

In the example above, we have a reactive called `initial_data`. This could be a
reactive that listens to user input and fetches some data from a database or
what ever, lets pretend this is a dataframe of lazy loaded tibble. We pass this
reactive to module server function named `apply_filter`. Let's asume this module
returns a subset of the data passed on to it. We repeat this 2 more times and
assign this new reactive to `global_data`.

This simplifies the process of interacting between modules. Furthermore, you can
control the flow of data really easily by adding the `bindEvent` function
between the pipes.

```R
# This is in the server.R
global_data <- initial_data() %>>%
  apply_filter(id = "phase1") %>>%
  apply_filter(id = "phase2") %>>%
  bindEvent(input$apply_filters) %>>%
  apply_filter(id = "phase3") %>>%
  bindEvent(input$apply_final_filter)
```

By adding `bindEvent` in between the piping, we can control what the user does.
If we want the user to first apply the phase1 and phase2 filters and then the
phase3 filter, we can easily control that in a very concise manner.

I included the code to a very basic app showing off this approach of writing
Shiny code. I would love to hear back from the community, thank you. This
currently only works with the pipe provided by the **pipeR** package due to
how things are evualuated with the magrittr and base pipes.
