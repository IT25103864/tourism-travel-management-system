package com.pearltrails.pearltrails.controller;

import com.itextpdf.kernel.pdf.PdfDocument;
import com.itextpdf.kernel.pdf.PdfWriter;
import com.itextpdf.layout.Document;
import com.itextpdf.layout.element.Paragraph;
import com.itextpdf.layout.properties.TextAlignment;
import com.pearltrails.pearltrails.model.Payment;
import com.pearltrails.pearltrails.repository.PaymentRepository;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class InvoiceController {

    @Autowired
    private PaymentRepository paymentRepository;

    @GetMapping("/download-invoice")
    public void downloadInvoice(@RequestParam("paymentId") Integer paymentId, HttpServletResponse response) throws Exception {
        Payment payment = paymentRepository.findById(paymentId).orElse(null);
        if (payment == null) return;

        // Set response headers for PDF download
        response.setContentType("application/pdf");
        response.setHeader("Content-Disposition", "attachment; filename=PearlTrails_Invoice_" + paymentId + ".pdf");

        // Create PDF
        PdfWriter writer = new PdfWriter(response.getOutputStream());
        PdfDocument pdf = new PdfDocument(writer);
        Document document = new Document(pdf);

        // Add Invoice Content
        document.add(new Paragraph("PearlTrails - Official Receipt").setBold().setFontSize(22).setTextAlignment(TextAlignment.CENTER));
        document.add(new Paragraph("----------------------------------------------------------------------"));
        document.add(new Paragraph("Payment ID: #" + payment.getPaymentId()));
        document.add(new Paragraph("Tourist Name: " + payment.getTourist().getFullName()));
        document.add(new Paragraph("Original Amount: $" + payment.getOriginalAmount()));
        document.add(new Paragraph("Discount Applied: $" + payment.getDiscountAmount()));
        document.add(new Paragraph("Final Amount Paid: $" + payment.getFinalAmount()).setBold());
        document.add(new Paragraph("Promo Code Used: " + (payment.getPromoCodeUsed() != null ? payment.getPromoCodeUsed() : "None")));
        document.add(new Paragraph("Date: " + payment.getPaymentDate().toString()));
        document.add(new Paragraph("----------------------------------------------------------------------"));
        document.add(new Paragraph("Thank you for choosing PearlTrails!").setTextAlignment(TextAlignment.CENTER));

        document.close();
    }
}