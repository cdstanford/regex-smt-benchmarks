;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^[A-Z0-9]{8}-[A-Z0-9]{4}-[A-Z0-9]{4}-[A-Z0-9]{4}-[A-Z0-9]{12}$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "Z929UZ88-Q02G-82Z9-95IN-9BXAER589D7S"
(define-fun Witness1 () String (seq.++ "Z" (seq.++ "9" (seq.++ "2" (seq.++ "9" (seq.++ "U" (seq.++ "Z" (seq.++ "8" (seq.++ "8" (seq.++ "-" (seq.++ "Q" (seq.++ "0" (seq.++ "2" (seq.++ "G" (seq.++ "-" (seq.++ "8" (seq.++ "2" (seq.++ "Z" (seq.++ "9" (seq.++ "-" (seq.++ "9" (seq.++ "5" (seq.++ "I" (seq.++ "N" (seq.++ "-" (seq.++ "9" (seq.++ "B" (seq.++ "X" (seq.++ "A" (seq.++ "E" (seq.++ "R" (seq.++ "5" (seq.++ "8" (seq.++ "9" (seq.++ "D" (seq.++ "7" (seq.++ "S" "")))))))))))))))))))))))))))))))))))))
;witness2: "289JZ9N8-0Q4X-B93Q-P9OJ-MV28809Z0V48"
(define-fun Witness2 () String (seq.++ "2" (seq.++ "8" (seq.++ "9" (seq.++ "J" (seq.++ "Z" (seq.++ "9" (seq.++ "N" (seq.++ "8" (seq.++ "-" (seq.++ "0" (seq.++ "Q" (seq.++ "4" (seq.++ "X" (seq.++ "-" (seq.++ "B" (seq.++ "9" (seq.++ "3" (seq.++ "Q" (seq.++ "-" (seq.++ "P" (seq.++ "9" (seq.++ "O" (seq.++ "J" (seq.++ "-" (seq.++ "M" (seq.++ "V" (seq.++ "2" (seq.++ "8" (seq.++ "8" (seq.++ "0" (seq.++ "9" (seq.++ "Z" (seq.++ "0" (seq.++ "V" (seq.++ "4" (seq.++ "8" "")))))))))))))))))))))))))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ ((_ re.loop 8 8) (re.union (re.range "0" "9") (re.range "A" "Z")))(re.++ (re.range "-" "-")(re.++ ((_ re.loop 4 4) (re.union (re.range "0" "9") (re.range "A" "Z")))(re.++ (re.range "-" "-")(re.++ ((_ re.loop 4 4) (re.union (re.range "0" "9") (re.range "A" "Z")))(re.++ (re.range "-" "-")(re.++ ((_ re.loop 4 4) (re.union (re.range "0" "9") (re.range "A" "Z")))(re.++ (re.range "-" "-")(re.++ ((_ re.loop 12 12) (re.union (re.range "0" "9") (re.range "A" "Z"))) (str.to_re "")))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
