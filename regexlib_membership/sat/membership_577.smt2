;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = [a-zA-Z Á-Úá-ú][^1234567890]+$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "\u00BE\u00F5\xBj"
(define-fun Witness1 () String (seq.++ "\xbe" (seq.++ "\xf5" (seq.++ "\x0b" (seq.++ "j" "")))))
;witness2: ":\x1C\u00E6S"
(define-fun Witness2 () String (seq.++ ":" (seq.++ "\x1c" (seq.++ "\xe6" (seq.++ "S" "")))))

(assert (= regexA (re.++ (re.union (re.range " " " ")(re.union (re.range "A" "Z")(re.union (re.range "a" "z")(re.union (re.range "\xc1" "\xda") (re.range "\xe1" "\xfa")))))(re.++ (re.+ (re.union (re.range "\x00" "/") (re.range ":" "\xff"))) (str.to_re "")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
