/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import entity.Customer;
import java.util.List;
import javax.ejb.Local;

/**
 *
 * @author naresh
 */
@Local
public interface CustomerDAO {

    void create(Customer customer);

    void edit(Customer customer);

    void remove(Customer customer);

    Customer find(Object id);

    List<Customer> findAll();

    List<Customer> findRange(int[] range);

    int count();
    
    Customer authenticateUser(String login, String password);    
    
    boolean isLoginIDAvailable(String login);
}
