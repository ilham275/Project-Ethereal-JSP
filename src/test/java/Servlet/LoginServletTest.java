/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/UnitTests/JUnit5TestClass.java to edit this template
 */
package Servlet;
import org.junit.Before;
import org.junit.Test;
import org.mockito.Mock;
import org.mockito.Mockito;
import org.mockito.MockitoAnnotations;

import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

public class LoginServletTest {

    @Mock
    private HttpServletRequest request;

    @Mock
    private HttpServletResponse response;

    @Mock
    private RequestDispatcher dispatcher;

    @Mock
    private HttpSession session;

    private LoginServlet loginServlet;

    @Before
    public void setUp() {
        MockitoAnnotations.initMocks(this);
        loginServlet = new LoginServlet();
    }

    @Test
    public void testDoPostWithValidCredentials() throws Exception {
        // Set up your mock objects and behavior for a valid login scenario
        Mockito.when(request.getParameter("username")).thenReturn("admin");
        Mockito.when(request.getParameter("password")).thenReturn("admin");
        Mockito.when(request.getSession()).thenReturn(session);
        Mockito.when(request.getRequestDispatcher("index.jsp")).thenReturn(dispatcher);

        // Call the servlet's doPost method
        loginServlet.doPost(request, response);

        // Verify that the dispatcher forwards to the expected page
        Mockito.verify(dispatcher).forward(request, response);
    }

    @Test
    public void testDoPostWithInvalidCredentials() throws Exception {
        // Set up your mock objects and behavior for an invalid login scenario
        Mockito.when(request.getParameter("username")).thenReturn("admin");
        Mockito.when(request.getParameter("password")).thenReturn("admin");
        Mockito.when(request.getSession()).thenReturn(session);
        Mockito.when(request.getRequestDispatcher("login.jsp")).thenReturn(dispatcher);

        // Call the servlet's doPost method
        loginServlet.doPost(request, response);

        // Verify that the dispatcher forwards to the expected page
        Mockito.verify(dispatcher).forward(request, response);
    }
}
