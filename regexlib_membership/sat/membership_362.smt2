;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ([0-9]{6}|[0-9]{3}\s[0-9]{3})
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "\x13o792388"
(define-fun Witness1 () String (seq.++ "\x13" (seq.++ "o" (seq.++ "7" (seq.++ "9" (seq.++ "2" (seq.++ "3" (seq.++ "8" (seq.++ "8" "")))))))))
;witness2: "398\xD978"
(define-fun Witness2 () String (seq.++ "3" (seq.++ "9" (seq.++ "8" (seq.++ "\x0d" (seq.++ "9" (seq.++ "7" (seq.++ "8" ""))))))))

(assert (= regexA (re.union ((_ re.loop 6 6) (re.range "0" "9")) (re.++ ((_ re.loop 3 3) (re.range "0" "9"))(re.++ (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))) ((_ re.loop 3 3) (re.range "0" "9")))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
