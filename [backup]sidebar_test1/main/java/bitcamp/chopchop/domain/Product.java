package bitcamp.chopchop.domain;

import java.util.List;
import bitcamp.chopchop.domain.PhotoFile;

public class Product {
  private int productNo;
  private String title;
  private int price;
  private String detail;
  private int stock;
  private int discount;
  private String category;
  private String species;
  private int viewCount;
  private Member member;

  private List<PhotoFile> files;
  private List<Comment> comments;
  private List<ProductOption> options;

  @Override
  public String toString() {
    return "Product [productNo=" + productNo + ", title=" + title + ", price=" + price + ", detail="
        + detail + ", stock=" + stock + ", discount=" + discount + ", category=" + category
        + ", species=" + species + ", viewCount=" + viewCount + ", member=" + member + ", files="
        + files + ", comments=" + comments + ", options=" + options + "]";
  }

  public int getProductNo() {
    return productNo;
  }

  public void setProductNo(int productNo) {
    this.productNo = productNo;
  }

  public String getTitle() {
    return title;
  }

  public void setTitle(String title) {
    this.title = title;
  }

  public int getPrice() {
    return price;
  }

  public void setPrice(int price) {
    this.price = price;
  }

  public String getDetail() {
    return detail;
  }

  public void setDetail(String detail) {
    this.detail = detail;
  }

  public int getStock() {
    return stock;
  }

  public void setStock(int stock) {
    this.stock = stock;
  }

  public int getDiscount() {
    return discount;
  }

  public void setDiscount(int discount) {
    this.discount = discount;
  }

  public String getCategory() {
    return category;
  }

  public void setCategory(String category) {
    this.category = category;
  }

  public String getSpecies() {
    return species;
  }

  public void setSpecies(String species) {
    this.species = species;
  }

  public int getViewCount() {
    return viewCount;
  }

  public void setViewCount(int viewCount) {
    this.viewCount = viewCount;
  }

  public Member getMember() {
    return member;
  }

  public void setMember(Member member) {
    this.member = member;
  }

  public List<PhotoFile> getFiles() {
    return files;
  }

  public void setFiles(List<PhotoFile> files) {
    this.files = files;
  }

  public List<Comment> getComments() {
    return comments;
  }

  public void setComments(List<Comment> comments) {
    this.comments = comments;
  }

  public List<ProductOption> getOptions() {
    return options;
  }

  public void setOptions(List<ProductOption> options) {
    this.options = options;
  }


}
