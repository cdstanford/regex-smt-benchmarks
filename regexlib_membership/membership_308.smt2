;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(http\://){1}(((www\.){1}([a-zA-Z0-9\-]*\.){1,}){1}|([a-zA-Z0-9\-]*\.){1,10}){1}([a-zA-Z]{2,6}\.){1}([a-zA-Z0-9\-\._\?\,\'/\\\+&amp;%\$#\=~])*
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "http://www.-.-.zKqU."
(define-fun Witness1 () String (str.++ "h" (str.++ "t" (str.++ "t" (str.++ "p" (str.++ ":" (str.++ "/" (str.++ "/" (str.++ "w" (str.++ "w" (str.++ "w" (str.++ "." (str.++ "-" (str.++ "." (str.++ "-" (str.++ "." (str.++ "z" (str.++ "K" (str.++ "q" (str.++ "U" (str.++ "." "")))))))))))))))))))))
;witness2: "http://www..ZaB.&\x11y\u00DB\x0"
(define-fun Witness2 () String (str.++ "h" (str.++ "t" (str.++ "t" (str.++ "p" (str.++ ":" (str.++ "/" (str.++ "/" (str.++ "w" (str.++ "w" (str.++ "w" (str.++ "." (str.++ "." (str.++ "Z" (str.++ "a" (str.++ "B" (str.++ "." (str.++ "&" (str.++ "\u{11}" (str.++ "y" (str.++ "\u{db}" (str.++ "\u{00}" ""))))))))))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (str.to_re (str.++ "h" (str.++ "t" (str.++ "t" (str.++ "p" (str.++ ":" (str.++ "/" (str.++ "/" ""))))))))(re.++ (re.union (re.++ (str.to_re (str.++ "w" (str.++ "w" (str.++ "w" (str.++ "." ""))))) (re.+ (re.++ (re.* (re.union (re.range "-" "-")(re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z"))))) (re.range "." ".")))) ((_ re.loop 1 10) (re.++ (re.* (re.union (re.range "-" "-")(re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z"))))) (re.range "." "."))))(re.++ (re.++ ((_ re.loop 2 6) (re.union (re.range "A" "Z") (re.range "a" "z"))) (re.range "." ".")) (re.* (re.union (re.range "#" "'")(re.union (re.range "+" "9")(re.union (re.range ";" ";")(re.union (re.range "=" "=")(re.union (re.range "?" "?")(re.union (re.range "A" "Z")(re.union (re.range "\u{5c}" "\u{5c}")(re.union (re.range "_" "_")(re.union (re.range "a" "z") (re.range "~" "~")))))))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
