package org.storage.metadata.security;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.HttpMethod;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.method.configuration.EnableGlobalMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;
import org.storage.metadata.model.Role;
import org.storage.metadata.repository.UserRepository;
import org.storage.metadata.security.jwt.JWTFilter;
import org.storage.metadata.security.services.CustomUserDetailsService;
import org.storage.metadata.service.UserAuthService;

import javax.servlet.http.HttpServletResponse;

@Configuration
@EnableWebSecurity
@EnableGlobalMethodSecurity(prePostEnabled = true)
public class WebSecurityConfig extends WebSecurityConfigurerAdapter {
    @Autowired
    private final CustomUserDetailsService userDetailsService;

    private UserRepository userRepo;
    @Autowired
    private JWTFilter filter;

    public WebSecurityConfig(CustomUserDetailsService databaseUserDetailsService) {
        this.userDetailsService = databaseUserDetailsService;
    }



    @Bean
    public PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }

   /* @Override
    protected void configure(AuthenticationManagerBuilder auth) throws Exception {
        auth.userDetailsService(userDetailsService)
                .passwordEncoder(passwordEncoder());
    }*/

    @Override
    @Bean
    public AuthenticationManager authenticationManagerBean() throws Exception {
        return super.authenticationManagerBean();
    }

    @Override
    protected void configure(HttpSecurity http) throws Exception {
        http
                .csrf().disable()
                .httpBasic().disable()
                .cors()
                .and()
                .authorizeHttpRequests()
                .antMatchers("/api/auth/**").permitAll()
                //.antMatchers("/users/**").hasRole("ROLE_ADMIN")
                .anyRequest().authenticated()
                .and()
                .userDetailsService(userDetailsService)
                .exceptionHandling()
                .authenticationEntryPoint(
                        (request, response, authException) ->
                                response.sendError(HttpServletResponse.SC_UNAUTHORIZED, "Unauthorized")
                )
                .and()
                .sessionManagement()
                .sessionCreationPolicy(SessionCreationPolicy.STATELESS);
        http.addFilterBefore(filter, UsernamePasswordAuthenticationFilter.class);
    }
}
/*.csrf().disable()
        .authorizeHttpRequests()
        //.antMatchers(HttpMethod.GET, "/**").permitAll()
        .antMatchers("/**").hasRole("ADMIN")
        .anyRequest()
        .authenticated()
        .and()
        .httpBasic().disable()
        .exceptionHandling()
        .authenticationEntryPoint(
        (request, response, authException) ->
        response.sendError(HttpServletResponse.SC_UNAUTHORIZED, "Unauthorized")
        ); */