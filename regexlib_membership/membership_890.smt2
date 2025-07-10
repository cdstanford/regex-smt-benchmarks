;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (?:(?:w{3}\.)(?:[a-zA-Z0-9/;\?&=:\-_\$\+!\*'\(\|\\~\[\]#%\.])+[\.com|\.edu|\.gov|\.int|\.mil|\.net|\.org|\.biz|\.info|\.name|\.pro|\.aero|\.coop|\.museum|\.cat|\.jobs|\.travel|\.arpa|\.mobi|\.ac|\.ad|\.ae|\.af|\.ag|\.ai|\.al|\.am|\.an|\.ao|\.aq|\.ar|\.as|\.at|\.au|\.aw|\.az|\.ax|\.ba|\.bb|\.bd|\.be|\.bf|\.bg|\.bh|\.bi|\.bj|\.bm|\.bn|\.bo|\.br|\.bs|\.bt|\.bv|\.bw|\.by|\.bz|\.ca|\.cc|\.cd|\.cf|\.cg|\.ch|\.ci|\.ck|\.cl|\.cm|\.cn|\.co|\.cr|\.cs|\.cu|\.cv|\.cx|\.cy|\.cz|\.de|\.dj|\.dk|\.dm|\.do|\.dz|\.ec|\.ee|\.eg|\.eh|\.er|\.es|\.et|\.eu|\.fi|\.fj|\.fk|\.fm|\.fo|\.fr|\.ga|\.gb|\.gd|\.ge|\.gf|\.gg|\.gh|\.gi|\.gl|\.gm|\.gn|\.gp|\.gq|\.gr|\.gs|\.gt|\.gu|\.gw|\.gy|\.hk|\.hm|\.hn|\.hr|\.ht|\.hu|\.id|\.ie|\.il|\.im|\.in|\.io|\.iq|\.ir|\.is|\.it|\.je|\.jm|\.jo|\.jp|\.ke|\.kg|\.kh|\.ki|\.km|\.kn|\.kp|\.kr|\.kw|\.ky|\.kz|\.la|\.lb|\.lc|\.li|\.lk|\.lr|\.ls|\.lt|\.lu|\.lv|\.ly|\.ma|\.mc|\.md|\.mg|\.mh|\.mk|\.ml|\.mm|\.mn|\.mo|\.mp|\.mq|\.mr|\.ms|\.mt|\.mu|\.mv|\.mw|\.mx|\.my|\.mz|\.na|\.nc|\.ne|\.nf|\.ng|\.ni|\.nl|\.no|\.np|\.nr|\.nu|\.nz|\.om|\.pa|\.pe|\.pf|\.pg|\.ph|\.pk|\.pl|\.pm|\.pn|\.pr|\.ps|\.pt|\.pw|\.py|\.qa|\.re|\.ro|\.ru|\.rw|\.sa|\.sb|\.sc|\.sd|\.se|\.sg|\.sh|\..si|\.sj|\.sk|\.sl|\.sm|\.sn|\.so|\.sr|\.st|\.sv|\.sy|\.sz|\.tc|\.td|\.tf|\.tg|\.th|\.tj|\.tk|\.tl|\.tm|\.tn|\.to|\.tp|\.tr|\.tt|\.tv|\.tw|\.tz|\.ua|\.ug|\.uk|\.um|\.us|\.uy|\.uz|\.va|\.vc|\.ve|\.vg|\.vi|\.vn|\.vu|\.wf|\.ws|\.ye|\.yt|\.yu|\.za|\.zm|\.zw](?:[a-zA-Z0-9/;\?&=:\-_\$\+!\*'\(\|\\~\[\]#%\.])*)
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "\u00F1\u00D9\u00FFwww.Aj"
(define-fun Witness1 () String (str.++ "\u{f1}" (str.++ "\u{d9}" (str.++ "\u{ff}" (str.++ "w" (str.++ "w" (str.++ "w" (str.++ "." (str.++ "A" (str.++ "j" ""))))))))))
;witness2: "Ewww.~9.:"
(define-fun Witness2 () String (str.++ "E" (str.++ "w" (str.++ "w" (str.++ "w" (str.++ "." (str.++ "~" (str.++ "9" (str.++ "." (str.++ ":" ""))))))))))

(assert (= regexA (re.++ ((_ re.loop 3 3) (re.range "w" "w"))(re.++ (re.range "." ".")(re.++ (re.+ (re.union (re.range "!" "!")(re.union (re.range "#" "(")(re.union (re.range "*" "+")(re.union (re.range "-" ";")(re.union (re.range "=" "=")(re.union (re.range "?" "?")(re.union (re.range "A" "]")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "|" "|") (re.range "~" "~"))))))))))))(re.++ (re.union (re.range "." ".")(re.union (re.range "a" "z") (re.range "|" "|"))) (re.* (re.union (re.range "!" "!")(re.union (re.range "#" "(")(re.union (re.range "*" "+")(re.union (re.range "-" ";")(re.union (re.range "=" "=")(re.union (re.range "?" "?")(re.union (re.range "A" "]")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "|" "|") (re.range "~" "~"))))))))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
