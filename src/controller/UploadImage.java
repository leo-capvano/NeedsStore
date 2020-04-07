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
        if(ServletFileUpload.isMultipartContent(req)){
            try {
                ServletFileUpload sf = new ServletFileUpload(new DiskFileItemFactory());
                List<FileItem> items = sf.parseRequest(req);

                for (FileItem item : items){
                    filePath = "C:\\Users\\leoca\\IdeaProjects\\NeedsStore\\web\\images\\"+item.getName();
                    item.write(new File(filePath));
                }
            } catch (FileUploadException e) {
                e.printStackTrace();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        Articolo newArticolo = (Articolo) req.getSession().getAttribute("newArticolo");

        Album album = new Album(UUID.randomUUID().toString(),filePath,newArticolo.getIdArticolo());

        ArticoloDAO ardao = new ArticoloDAO();
        AlbumDAO aldao = new AlbumDAO();
        ardao.doPublish(newArticolo);
        aldao.doInsertAlbum(album);

        //articolo pubblicato
        resp.sendRedirect("homepage.jsp");

    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req,resp);
    }

}
