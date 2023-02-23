
full_workflow <- function(J, v, p_table = NULL) {
  
  toy_params <- get_parameters(J, v)
  
  fish_draws <- draw_from_logseries(toy_params)
  fs_draws <- draw_from_feasible_set(toy_params, p_table = p_table)
  
  fish_summary <- summarize_draws(fish_draws)
  fs_summary <- summarize_draws(fs_draws)
  
  h1_wilcox <- compare_wilcox(fish_summary$hill1, fs_summary$hill1) %>%
    mutate(var = "hill1")
  h2_wilcox <- compare_wilcox(fish_summary$hill2, fs_summary$hill2) %>%
    mutate(var = "hill2")
  even_wilcox <- compare_wilcox(fish_summary$even, fs_summary$even) %>%
    mutate(var = "even")
  
  output <- bind_rows(
    h1_wilcox,
    h2_wilcox,
    even_wilcox) %>%
    cbind(toy_params)
  
  return(output)
  
}
