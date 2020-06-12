package controller;

import model.Album;
import model.AlbumDAO;
import model.Articolo;
import model.ArticoloDAO;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.taglibs.standard.lang.jstl.Constants;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;


@WebServlet("/UploadImage")
@MultipartConfig(fileSizeThreshold = 1024 * 1024,
        maxFileSize = 1024 * 1024 * 7,
        maxRequestSize = 1024 * 1024 * 7 * 7)
public class UploadImage extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        String filePath = "";
        String filename = "";
        List<FileItem> items = new ArrayList<FileItem>();
        ArrayList<String> filenames = new ArrayList<>();
        InputStream in = null;
        File uploadPath = new File("C:\\Users\\leoca\\Desktop\\immagini");
        if(ServletFileUpload.isMultipartContent(req)){
            try {
                ServletFileUpload sf = new ServletFileUpload(new DiskFileItemFactory());
                items = sf.parseRequest(req);

                for (FileItem item : items){
                    filename = ((int)(Math.random()*1000))+item.getName();
                    in = item.getInputStream();
                    File newFile = new File(uploadPath, filename);
                    Files.copy(in,newFile.toPath());
                    filenames.add(filename);
                }
            } catch (FileUploadException e) {
                e.printStackTrace();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        Articolo newArticolo = (Articolo) req.getSession().getAttribute("newArticolo");

        //scrivi l'articolo nel db
        ArticoloDAO ardao = new ArticoloDAO();
        ardao.doPublish(newArticolo);

        //creare e scrivere tanti album per quanti sono gli items(foto caricate)
        for (int i=0; i<filenames.size(); i++){
            AlbumDAO aldao = new AlbumDAO();
            Album album = new Album(UUID.randomUUID().toString(),"/immagini/"+filenames.get(i),newArticolo.getIdArticolo());
            aldao.doInsertAlbum(album);
        }

        //articolo pubblicato
        resp.sendRedirect("homepage.jsp");

    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req,resp);
    }

}
