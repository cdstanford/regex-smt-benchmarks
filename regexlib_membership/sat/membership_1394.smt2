;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (((0[123456789]|10|11|12)([/])(([1][9][0-9][0-9])|([2][0-9][0-9][0-9]))))
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "11/1989="
(define-fun Witness1 () String (seq.++ "1" (seq.++ "1" (seq.++ "/" (seq.++ "1" (seq.++ "9" (seq.++ "8" (seq.++ "9" (seq.++ "=" "")))))))))
;witness2: "\u00D710/1983"
(define-fun Witness2 () String (seq.++ "\xd7" (seq.++ "1" (seq.++ "0" (seq.++ "/" (seq.++ "1" (seq.++ "9" (seq.++ "8" (seq.++ "3" "")))))))))

(assert (= regexA (re.++ (re.union (re.++ (re.range "0" "0") (re.range "1" "9"))(re.union (str.to_re (seq.++ "1" (seq.++ "0" "")))(re.union (str.to_re (seq.++ "1" (seq.++ "1" ""))) (str.to_re (seq.++ "1" (seq.++ "2" ""))))))(re.++ (re.range "/" "/") (re.union (re.++ (str.to_re (seq.++ "1" (seq.++ "9" "")))(re.++ (re.range "0" "9") (re.range "0" "9"))) (re.++ (re.range "2" "2")(re.++ (re.range "0" "9")(re.++ (re.range "0" "9") (re.range "0" "9")))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
