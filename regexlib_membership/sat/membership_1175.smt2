;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ((http\://|https\://|ftp\://)|(www.))+(([a-zA-Z0-9\.-]+\.[a-zA-Z]{2,4})|([0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}))(/[a-zA-Z0-9%:/-_\?\.'~]*)?
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "pwww\x1Bftp://ftp://..qBm"
(define-fun Witness1 () String (seq.++ "p" (seq.++ "w" (seq.++ "w" (seq.++ "w" (seq.++ "\x1b" (seq.++ "f" (seq.++ "t" (seq.++ "p" (seq.++ ":" (seq.++ "/" (seq.++ "/" (seq.++ "f" (seq.++ "t" (seq.++ "p" (seq.++ ":" (seq.++ "/" (seq.++ "/" (seq.++ "." (seq.++ "." (seq.++ "q" (seq.++ "B" (seq.++ "m" "")))))))))))))))))))))))
;witness2: "wwwOhttps://9.8.583.3"
(define-fun Witness2 () String (seq.++ "w" (seq.++ "w" (seq.++ "w" (seq.++ "O" (seq.++ "h" (seq.++ "t" (seq.++ "t" (seq.++ "p" (seq.++ "s" (seq.++ ":" (seq.++ "/" (seq.++ "/" (seq.++ "9" (seq.++ "." (seq.++ "8" (seq.++ "." (seq.++ "5" (seq.++ "8" (seq.++ "3" (seq.++ "." (seq.++ "3" ""))))))))))))))))))))))

(assert (= regexA (re.++ (re.+ (re.union (re.union (str.to_re (seq.++ "h" (seq.++ "t" (seq.++ "t" (seq.++ "p" (seq.++ ":" (seq.++ "/" (seq.++ "/" ""))))))))(re.union (str.to_re (seq.++ "h" (seq.++ "t" (seq.++ "t" (seq.++ "p" (seq.++ "s" (seq.++ ":" (seq.++ "/" (seq.++ "/" ""))))))))) (str.to_re (seq.++ "f" (seq.++ "t" (seq.++ "p" (seq.++ ":" (seq.++ "/" (seq.++ "/" ""))))))))) (re.++ (str.to_re (seq.++ "w" (seq.++ "w" (seq.++ "w" "")))) (re.union (re.range "\x00" "\x09") (re.range "\x0b" "\xff")))))(re.++ (re.union (re.++ (re.+ (re.union (re.range "-" ".")(re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z")))))(re.++ (re.range "." ".") ((_ re.loop 2 4) (re.union (re.range "A" "Z") (re.range "a" "z"))))) (re.++ ((_ re.loop 1 3) (re.range "0" "9"))(re.++ (re.range "." ".")(re.++ ((_ re.loop 1 3) (re.range "0" "9"))(re.++ (re.range "." ".")(re.++ ((_ re.loop 1 3) (re.range "0" "9"))(re.++ (re.range "." ".") ((_ re.loop 1 3) (re.range "0" "9"))))))))) (re.opt (re.++ (re.range "/" "/") (re.* (re.union (re.range "%" "%")(re.union (re.range "'" "'")(re.union (re.range "." "_")(re.union (re.range "a" "z") (re.range "~" "~"))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
