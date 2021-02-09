;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ((\d{0}[0-9]|\d{0}[1]\d{0}[0-2])(\:)\d{0}[0-5]\d{0}[0-9](\:)\d{0}[0-5]\d{0}[0-9]\s(AM|PM))
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "12:48:15\u00A0PM"
(define-fun Witness1 () String (seq.++ "1" (seq.++ "2" (seq.++ ":" (seq.++ "4" (seq.++ "8" (seq.++ ":" (seq.++ "1" (seq.++ "5" (seq.++ "\xa0" (seq.++ "P" (seq.++ "M" ""))))))))))))
;witness2: "4:49:42\x9PMXR"
(define-fun Witness2 () String (seq.++ "4" (seq.++ ":" (seq.++ "4" (seq.++ "9" (seq.++ ":" (seq.++ "4" (seq.++ "2" (seq.++ "\x09" (seq.++ "P" (seq.++ "M" (seq.++ "X" (seq.++ "R" "")))))))))))))

(assert (= regexA (re.++ (re.union (re.range "0" "9") (re.++ (re.range "1" "1") (re.range "0" "2")))(re.++ (re.range ":" ":")(re.++ (re.range "0" "5")(re.++ (re.range "0" "9")(re.++ (re.range ":" ":")(re.++ (re.range "0" "5")(re.++ (re.range "0" "9")(re.++ (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))) (re.union (str.to_re (seq.++ "A" (seq.++ "M" ""))) (str.to_re (seq.++ "P" (seq.++ "M" ""))))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
