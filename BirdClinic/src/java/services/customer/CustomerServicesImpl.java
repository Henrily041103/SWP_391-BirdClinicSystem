/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package services.customer;

import java.sql.SQLException;
import java.sql.Date;
import java.util.List;
import java.util.Map;
import models.appointment.AppointmentAlreadyExistsException;
import models.appointment.AppointmentDTO;
import models.appointment.AppointmentDTOImpl;
import models.bird.BirdAlreadyExistsException;
import models.bird.BirdDTO;
import models.bird.BirdDTOImpl;
import models.exceptions.NoSuchRecordExists;
import models.exceptions.RecordAlreadyExists;
import models.feedback.FeedbackDTO;
import models.images.ImageDTO;
import models.medicalRecord.MedicalRecordDTO;
import models.recordMedicine.RecordMedicineDTO;
import models.service_.Service_DTO;
import models.timeslot.TimeslotDTO;
import models.users.UserDTO;
import models.users.customer.CustomerDTO;
import services.general.AppointmentDoesNotExistException;
import services.general.GeneralServicesImpl;
import services.general.BirdDoesNotExistException;
import utils.Utils;

/**
 *
 * @author Admin
 */
public class CustomerServicesImpl extends GeneralServicesImpl implements CustomerServices {

    public CustomerServicesImpl(UserDTO currentUser) throws SQLException {
        super();
        String customerID = currentUser.getUserID();
        try {
            CustomerDTO customer = customerDAO.readCustomer(customerID);
            this.currentUser = customer;
        } catch (NoSuchRecordExists ex) {
            //impossible bc controller will check role and initiates the right service -> db problem
            throw new SQLException(ex.getMessage());
        }

    }

    @Override
    public boolean bookAppointment(Map<String, String> args)
            throws AppointmentAlreadyExistsException, SQLException {
        boolean result = false;
        String birdID = args.get("birdID");
        String notes = args.get("notes");
        String timeslotID = args.get("timeslotID");
        String service_ID = args.get("serviceID");
        String appDate = args.get("appDate");
        String doctorID = args.get("doctorID");

        try {
            AppointmentDTO app = new AppointmentDTOImpl();
            app.setAppointmentID(Utils.hash(birdID + service_ID + timeslotID + String.valueOf(System.currentTimeMillis())));
            app.setAppStatus("processing");
            app.setBird(birdDAO.readBird(birdID));
            TimeslotDTO timeslot = timeslotDAO.readTimeSlot(timeslotID);
            app.setTimeslot(timeslot);
            if (doctorID == null) {
                app.setDoctor(null);
            } else {
                app.setDoctor(doctorDAO.readDoctor(doctorID));
            }
            app.setPayment(null);
            Service_DTO service = serviceDAO.readService_(service_ID);
            app.setService_(service);
            app.setNotes(notes);

            Date date = Date.valueOf(appDate);
            long milliseconds = date.getTime() + timeslot.getTimeSlot().getTime();
            app.setAppTime(new Date(milliseconds));

            result = appointmentDAO.insertAppointment(app) > 0;
        } catch (NoSuchRecordExists ex) {
            //impossible unless account/timeslot/service doesn't exist in db -> SQLException
            throw new SQLException(ex.getMessage());
        } catch (RecordAlreadyExists ex) {
            throw new AppointmentAlreadyExistsException();
        }
        System.out.println(result);
        return result;
    }

    @Override
    public List<BirdDTO> getCustomerBirds() throws SQLException {
        String customerID = currentUser.getUserID();
        List<BirdDTO> birds;

        try {
            birds = birdDAO.readAllBirdByCustomer(customerID);
        } catch (NoSuchRecordExists ex) {
            birds = null;
        }
        return birds;
    }

    @Override
    public List<AppointmentDTO> getCustomerAppointments() throws SQLException {
        String customerID = currentUser.getUserID();
        List<AppointmentDTO> apps;

        try {
            apps = appointmentDAO.readAppointmentByCustomer(customerID);
        } catch (NoSuchRecordExists ex) {
            apps = null;
        }
        return apps;
    }

    @Override
    public BirdDTO viewBird(String birdID)
            throws SQLException, BirdDoesNotExistException {
        BirdDTO bird = super.viewBird(birdID);
        if (!bird.getCustomer().getUserID().equals(currentUser.getUserID())) {
            bird = null;
        }
        return bird;
    }

    @Override
    public AppointmentDTO viewAppointment(String appointmentID) throws SQLException, AppointmentDoesNotExistException {
        AppointmentDTO app = super.viewAppointment(appointmentID);
        if (!app.getBird().getCustomer().getUserID().equals(currentUser.getUserID())) {
            app = null;
        }
        return app;
    }

    @Override
    public MedicalRecordDTO viewMedicalRecord(String appointmentID) throws SQLException {
        MedicalRecordDTO medRec = super.viewMedicalRecord(appointmentID);
        if (medRec != null) {
            if (!medRec.getAppointment().getBird().getCustomer().getUserID().equals(currentUser.getUserID())) {
                medRec = null;
            }
        }
        return medRec;
    }

    @Override
    public List<RecordMedicineDTO> viewRecordMeds(String medicalRecordID) throws SQLException {
        List<RecordMedicineDTO> recMeds = super.viewRecordMeds(medicalRecordID);
        if (recMeds != null) {
            if (!recMeds.get(0).getMedicalRecord().getAppointment().getBird().getCustomer().getUserID().equals(currentUser.getUserID())) {
                recMeds = null;
            }
        }

        return recMeds;
    }
    
    @Override
    public FeedbackDTO viewFeedback(String appointmentID) throws SQLException {
        FeedbackDTO feedback = super.viewFeedback(appointmentID);
        if (feedback!= null) {
            if (!feedback.getAppointment().getBird().getCustomer().getUserID().equals(currentUser.getUserID())) {
                feedback = null;
            }
        }
        
        return feedback;
    }

    @Override
    public boolean addBird(Map<String, String[]> args)
            throws BirdAlreadyExistsException, SQLException {
        boolean result = false;

        try {
            BirdDTO bird = new BirdDTOImpl();

            CustomerDTO customer = (CustomerDTO) this.currentUser;
            ImageDTO image = imageDAO.readImage("05b5b4345d8ac2f73ece3df15be03230"); //default

            String birdFullname = args.get("bird-full-name")[0];
            String birdGender = args.get("bird-gender")[0];
            String breed = args.get("breed")[0];
            String band_chip = args.get("band_chip")[0];
            float birdWeight = Float.parseFloat(args.get("bird-weight")[0]);
            String sexingMethod = args.get("sexing-method")[0];
            String medicalHistory = args.get("medical-history")[0];
            Date hatchingDate = Date.valueOf(args.get("hatching-date")[0]);
            String featherColor = args.get("feather-color")[0];

            bird.setBirdID(Utils.hash(customer.getUserID() + image.getImageID() + String.valueOf(System.currentTimeMillis())));

            bird.setCustomer(customer);
            bird.setImage(image);

            bird.setImage(image);
            bird.setBirdFullname(birdFullname);
            bird.setBirdGender(birdGender);
            bird.setBreed(breed);
            bird.setBand_Chip(band_chip);
            bird.setBirdWeight(birdWeight);
            bird.setSexingMethod(sexingMethod);
            bird.setMedicalHistory(medicalHistory);
            bird.setHatchingDate(hatchingDate);
            bird.setFeatherColor(featherColor);

            // Assuming you have a BirdDAO to interact with the bird table in the database
            // and the necessary methods like insertBird(BirdDTO bird) are implemented.
            int insertResult = birdDAO.insertBird(bird);

            result = insertResult > 0;
        } catch (NoSuchRecordExists ex) {
            throw new SQLException(ex.getMessage());
        } catch (RecordAlreadyExists ex) {
            throw new BirdAlreadyExistsException(ex.getMessage());
        }

        return result;
    }

    @Override
    public boolean deleteBird(String birdID)
            throws BirdDoesNotExistException, SQLException {
        boolean result = false;

        try {
            result = birdDAO.deleteBird(birdID) > 0;
        } catch (NoSuchRecordExists ex) {
            throw new BirdDoesNotExistException(ex.getMessage());
        }

        return result;
    }

    @Override
    public boolean updateBird(Map<String, String[]> args)
            throws BirdDoesNotExistException, SQLException {
        boolean result = false;

        try {
            String birdID = args.get("birdID")[0];
            BirdDTO bird = birdDAO.readBird(birdID);

            String imageID = Utils.getFromMap(args, "imageID", bird.getImage().getImageID());
            ImageDTO image = imageDAO.readImage(imageID);
            CustomerDTO customer = (CustomerDTO) this.currentUser;

            String birdFullname = Utils.getFromMap(args, "bird-full-name", bird.getBirdFullname());
            String birdGender = Utils.getFromMap(args, "bird-gender", bird.getBirdGender());
            String breed = Utils.getFromMap(args, "breed", bird.getBreed());
            String band_chip = Utils.getFromMap(args, "band_chip", bird.getBand_Chip());
            float birdWeight = Float.parseFloat(Utils.getFromMap(args, "bird-weight", String.valueOf(bird.getBirdWeight())));
            String sexingMethod = Utils.getFromMap(args, "sexing-method", bird.getSexingMethod());
            String medicalHistory = Utils.getFromMap(args, "medical-history", bird.getMedicalHistory());
            Date hatchingDate = Date.valueOf(Utils.getFromMap(args, "hatching-date", String.valueOf(bird.getHatchingDate())));
            String featherColor = Utils.getFromMap(args, "feather-color", bird.getFeatherColor());
            
            bird.setCustomer(customer);
            bird.setImage(image);
            bird.setBirdID(birdID);
            bird.setImage(image);
            bird.setBirdFullname(birdFullname);
            bird.setBirdGender(birdGender);
            bird.setBreed(breed);
            bird.setBand_Chip(band_chip);
            bird.setBirdWeight(birdWeight);
            bird.setSexingMethod(sexingMethod);
            bird.setMedicalHistory(medicalHistory);
            bird.setHatchingDate(hatchingDate);
            bird.setFeatherColor(featherColor);
            
            result = birdDAO.updateBird(bird) > 0;
        } catch (NoSuchRecordExists ex) {
            throw new BirdDoesNotExistException(ex.getMessage());
        }

        return result;
    }

}
