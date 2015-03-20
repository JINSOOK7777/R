# http://freesearch.pe.kr/archives/4298 
# 국토교통부 실거래가 데이터 크롤링 코드 by 전희원

install.packages("rvest")
install.packages("httr")
install.packages("stringi")
install.packages("XLConnect")
install.packages("data.table")

library(rvest)
library(httr)
library(stringi)
library(XLConnect)
library(data.table)

## 엑셀 데이터 다운로딩 부분
# 데이터는 working dir아래 data 디렉토리에 쌓인다. 따리서 data 디렉토리를 만들어 주자!

su <- file("succ.txt", "w")

agent_nm <- 
  "Mozilla/5.0 (Macintosh; Intel Mac OS X 10.10; rv:35.0) Gecko/20100101 Firefox/35.0"

maxidx <- html('http://rt.molit.go.kr/rtFile.do?cmd=list') %>% 
  html_nodes('.notiWhite1 .notiBorad01') %>%
  html_text %>% as.numeric %>% max

for(i in maxidx:1){
  urls_view <- sprintf("http://rt.molit.go.kr/rtFile.do?cmd=view&seqNo=%d", i)
  r <- GET(urls_view,
           user_agent(agent_nm))
  htxt <- html(r, "text")
  
  if((html_nodes(htxt, "td.notiBorad14")[[2]]  %>% 
        html_text()  %>% 
        stri_trim_both) == '첨부파일이 존재하지 않습니다.') next
  
  download_tags <- html_nodes(htxt, "td.notiBorad14")[[2]] %>%
    html_nodes('a[href^="javascript:jsDown"]')  
  
  for(dtag in download_tags){
    
    dtag %>% html_attr("href") %>% 
      stri_match_all_regex(pattern="javascript:jsDown\\('([0-9]+)','([0-9]+)'\\);") %>%
      .[[1]]  %>%  
{ 
  f_idx <<- .[2] %>% as.numeric
  s_idx <<- .[3] %>% as.numeric
}

f_nm <- dtag %>% html_text

urls <- sprintf("http://rt.molit.go.kr/rtFile.do?cmd=fileDownload&seq_no=%d&file_seq_no=%d", f_idx,s_idx)
r <- GET(urls,
         user_agent(agent_nm))
bin <- content(r, "raw")

#1kb 미만의 데이터는 버림(에러 페이지?) 
if(length(bin) < 1000) next
writeBin(bin, sprintf("data/%s",f_nm))
cat(sprintf("%d, %d\n", f_idx,s_idx), file = su)
print(sprintf("%d, %d", f_idx,s_idx))
  }
}

close(su)




## 엑셀 데이터에서 테이블을 추출해 하나의 아파트 매매 데이터로 통합하는 코드 
## 연립 다세대, 단독 다가 데이터도 간단한 코드 변환으로 통합할 수 있다. 


f_list <- list.files('data') %>%  
  stri_trans_nfc  %>% 
  .[stri_detect_fixed(.,'매매아파트')]

total_list <- list()

#파일의 각 시트(지역)를 data.table로 변환하고 필요 필드 추가함 
for(xlsf in f_list){
  wb <- loadWorkbook(paste0('data/',xlsf))
  sells <- list()
  fname <- stri_replace_last_fixed(xlsf, '.xls',"")
  yyyymm <- substring(fname, 1, 6)
  typenm <- substring(fname, 9)
  for(nm in getSheets(wb)) {
    df <- data.table(readWorksheet(wb, sheet = nm, header = TRUE))
    df[,`:=`(region=nm, yyyymm=yyyymm, typenm=typenm)]
    df[,`거래금액.만원.`:= stri_replace_all_fixed(`거래금액.만원.`, ',', '')]
    sells[[nm]] <- df
  }
  total_list[[paste0(yyyymm,typenm)]] <- rbindlist(sells)
}

result_sales_dt <- rbindlist(total_list)

#결과 데이터 저장 
save(result_sales_dt, file='result_sales_dt.RData')