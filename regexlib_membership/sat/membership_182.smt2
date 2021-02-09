;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = [a-z0-9][a-z0-9_\.-]{0,}[a-z0-9]\.[a-z0-9][a-z0-9_\.-]{0,}[a-z0-9][\.][cn]{2,4}
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "2i.4._ik.cccnM"
(define-fun Witness1 () String (seq.++ "2" (seq.++ "i" (seq.++ "." (seq.++ "4" (seq.++ "." (seq.++ "_" (seq.++ "i" (seq.++ "k" (seq.++ "." (seq.++ "c" (seq.++ "c" (seq.++ "c" (seq.++ "n" (seq.++ "M" "")))))))))))))))
;witness2: "t.1.zxj.nn"
(define-fun Witness2 () String (seq.++ "t" (seq.++ "." (seq.++ "1" (seq.++ "." (seq.++ "z" (seq.++ "x" (seq.++ "j" (seq.++ "." (seq.++ "n" (seq.++ "n" "")))))))))))

(assert (= regexA (re.++ (re.union (re.range "0" "9") (re.range "a" "z"))(re.++ (re.* (re.union (re.range "-" ".")(re.union (re.range "0" "9")(re.union (re.range "_" "_") (re.range "a" "z")))))(re.++ (re.union (re.range "0" "9") (re.range "a" "z"))(re.++ (re.range "." ".")(re.++ (re.union (re.range "0" "9") (re.range "a" "z"))(re.++ (re.* (re.union (re.range "-" ".")(re.union (re.range "0" "9")(re.union (re.range "_" "_") (re.range "a" "z")))))(re.++ (re.union (re.range "0" "9") (re.range "a" "z"))(re.++ (re.range "." ".") ((_ re.loop 2 4) (re.union (re.range "c" "c") (re.range "n" "n")))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
