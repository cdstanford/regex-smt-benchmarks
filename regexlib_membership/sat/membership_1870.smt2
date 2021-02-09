;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = [0-9]{4}\s*[a-zA-Z]{2}
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "1488\u00A0xJs"
(define-fun Witness1 () String (seq.++ "1" (seq.++ "4" (seq.++ "8" (seq.++ "8" (seq.++ "\xa0" (seq.++ "x" (seq.++ "J" (seq.++ "s" "")))))))))
;witness2: "5499\xC\u0085 XL\x2%"
(define-fun Witness2 () String (seq.++ "5" (seq.++ "4" (seq.++ "9" (seq.++ "9" (seq.++ "\x0c" (seq.++ "\x85" (seq.++ " " (seq.++ "X" (seq.++ "L" (seq.++ "\x02" (seq.++ "%" ""))))))))))))

(assert (= regexA (re.++ ((_ re.loop 4 4) (re.range "0" "9"))(re.++ (re.* (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0"))))) ((_ re.loop 2 2) (re.union (re.range "A" "Z") (re.range "a" "z")))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
