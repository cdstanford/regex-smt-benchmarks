;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ((http\://|https\://|ftp\://)|(www.))+(([a-zA-Z0-9\.-]+\.[a-zA-Z]{2,4})|([0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}))(/[a-zA-Z0-9%:/-_\?\.'~]*)?
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "pwww\x1Bftp://ftp://..qBm"
(define-fun Witness1 () String (str.++ "p" (str.++ "w" (str.++ "w" (str.++ "w" (str.++ "\u{1b}" (str.++ "f" (str.++ "t" (str.++ "p" (str.++ ":" (str.++ "/" (str.++ "/" (str.++ "f" (str.++ "t" (str.++ "p" (str.++ ":" (str.++ "/" (str.++ "/" (str.++ "." (str.++ "." (str.++ "q" (str.++ "B" (str.++ "m" "")))))))))))))))))))))))
;witness2: "wwwOhttps://9.8.583.3"
(define-fun Witness2 () String (str.++ "w" (str.++ "w" (str.++ "w" (str.++ "O" (str.++ "h" (str.++ "t" (str.++ "t" (str.++ "p" (str.++ "s" (str.++ ":" (str.++ "/" (str.++ "/" (str.++ "9" (str.++ "." (str.++ "8" (str.++ "." (str.++ "5" (str.++ "8" (str.++ "3" (str.++ "." (str.++ "3" ""))))))))))))))))))))))

(assert (= regexA (re.++ (re.+ (re.union (re.union (str.to_re (str.++ "h" (str.++ "t" (str.++ "t" (str.++ "p" (str.++ ":" (str.++ "/" (str.++ "/" ""))))))))(re.union (str.to_re (str.++ "h" (str.++ "t" (str.++ "t" (str.++ "p" (str.++ "s" (str.++ ":" (str.++ "/" (str.++ "/" ""))))))))) (str.to_re (str.++ "f" (str.++ "t" (str.++ "p" (str.++ ":" (str.++ "/" (str.++ "/" ""))))))))) (re.++ (str.to_re (str.++ "w" (str.++ "w" (str.++ "w" "")))) (re.union (re.range "\u{00}" "\u{09}") (re.range "\u{0b}" "\u{ff}")))))(re.++ (re.union (re.++ (re.+ (re.union (re.range "-" ".")(re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z")))))(re.++ (re.range "." ".") ((_ re.loop 2 4) (re.union (re.range "A" "Z") (re.range "a" "z"))))) (re.++ ((_ re.loop 1 3) (re.range "0" "9"))(re.++ (re.range "." ".")(re.++ ((_ re.loop 1 3) (re.range "0" "9"))(re.++ (re.range "." ".")(re.++ ((_ re.loop 1 3) (re.range "0" "9"))(re.++ (re.range "." ".") ((_ re.loop 1 3) (re.range "0" "9"))))))))) (re.opt (re.++ (re.range "/" "/") (re.* (re.union (re.range "%" "%")(re.union (re.range "'" "'")(re.union (re.range "." "_")(re.union (re.range "a" "z") (re.range "~" "~"))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
