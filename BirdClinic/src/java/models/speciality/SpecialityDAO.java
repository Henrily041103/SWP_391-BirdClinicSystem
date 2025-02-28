/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package models.speciality;

import java.io.Serializable;
import java.sql.SQLException;
import java.util.List;

/**
 *
 * @author Admin
 */
public interface SpecialityDAO extends Serializable {

    List<SpecialityDTO> readAllSpecialities() 
            throws NoSuchSpecialityExistsException, SQLException;

    SpecialityDTO readSpeciality(String specialityID) 
            throws NoSuchSpecialityExistsException, SQLException;

    List<SpecialityDTO> readListOfSpecialities(List<String> specialityIDs) 
            throws NoSuchSpecialityExistsException, SQLException;
}
