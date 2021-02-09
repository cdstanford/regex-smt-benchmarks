;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(\d{5}((|-)-\d{4})?)|([A-Za-z]\d[A-Za-z][\s\.\-]?(|-)\d[A-Za-z]\d)|[A-Za-z]{1,2}\d{1,2}[A-Za-z]? \d[A-Za-z]{2}$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "sa98 0oQ"
(define-fun Witness1 () String (seq.++ "s" (seq.++ "a" (seq.++ "9" (seq.++ "8" (seq.++ " " (seq.++ "0" (seq.++ "o" (seq.++ "Q" "")))))))))
;witness2: "Y38B 9kz"
(define-fun Witness2 () String (seq.++ "Y" (seq.++ "3" (seq.++ "8" (seq.++ "B" (seq.++ " " (seq.++ "9" (seq.++ "k" (seq.++ "z" "")))))))))

(assert (= regexA (re.union (re.++ (str.to_re "") (re.++ ((_ re.loop 5 5) (re.range "0" "9")) (re.opt (re.++ (re.union (str.to_re "") (re.range "-" "-"))(re.++ (re.range "-" "-") ((_ re.loop 4 4) (re.range "0" "9")))))))(re.union (re.++ (re.union (re.range "A" "Z") (re.range "a" "z"))(re.++ (re.range "0" "9")(re.++ (re.union (re.range "A" "Z") (re.range "a" "z"))(re.++ (re.opt (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "-" ".")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0"))))))(re.++ (re.union (str.to_re "") (re.range "-" "-"))(re.++ (re.range "0" "9")(re.++ (re.union (re.range "A" "Z") (re.range "a" "z")) (re.range "0" "9")))))))) (re.++ ((_ re.loop 1 2) (re.union (re.range "A" "Z") (re.range "a" "z")))(re.++ ((_ re.loop 1 2) (re.range "0" "9"))(re.++ (re.opt (re.union (re.range "A" "Z") (re.range "a" "z")))(re.++ (re.range " " " ")(re.++ (re.range "0" "9")(re.++ ((_ re.loop 2 2) (re.union (re.range "A" "Z") (re.range "a" "z"))) (str.to_re "")))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
