/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import entity.UserQuery;
import java.util.List;
import javax.ejb.Local;

/**
 *
 * @author naresh
 */
@Local
public interface UserQueryDAO {

    void create(UserQuery userQuery);

    void edit(UserQuery userQuery);

    void remove(UserQuery userQuery);

    UserQuery find(Object id);

    List<UserQuery> findAll();

    List<UserQuery> findRange(int[] range);

    int count();
    
    List<UserQuery> getUnResolvedQuery();
    
    List<UserQuery> getResolvedQuery();
    
    boolean updateQueryStatus(int queryId, boolean isResolved);
}
