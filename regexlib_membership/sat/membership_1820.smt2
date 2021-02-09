;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ([A-Z]:\\[^/:\*\?<>\|]+\.\w{2,6})|(\\{2}[^/:\*\?<>\|]+\.\w{2,6})
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "\x1\u00A8%L:\\x18\x9.9x\u00C6"
(define-fun Witness1 () String (seq.++ "\x01" (seq.++ "\xa8" (seq.++ "%" (seq.++ "L" (seq.++ ":" (seq.++ "\x5c" (seq.++ "\x18" (seq.++ "\x09" (seq.++ "." (seq.++ "9" (seq.++ "x" (seq.++ "\xc6" "")))))))))))))
;witness2: "CY\x11R:\H.e\u00C9jB\u00EE9*J"
(define-fun Witness2 () String (seq.++ "C" (seq.++ "Y" (seq.++ "\x11" (seq.++ "R" (seq.++ ":" (seq.++ "\x5c" (seq.++ "H" (seq.++ "." (seq.++ "e" (seq.++ "\xc9" (seq.++ "j" (seq.++ "B" (seq.++ "\xee" (seq.++ "9" (seq.++ "*" (seq.++ "J" "")))))))))))))))))

(assert (= regexA (re.union (re.++ (re.range "A" "Z")(re.++ (str.to_re (seq.++ ":" (seq.++ "\x5c" "")))(re.++ (re.+ (re.union (re.range "\x00" ")")(re.union (re.range "+" ".")(re.union (re.range "0" "9")(re.union (re.range ";" ";")(re.union (re.range "=" "=")(re.union (re.range "@" "{") (re.range "}" "\xff"))))))))(re.++ (re.range "." ".") ((_ re.loop 2 6) (re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\xaa" "\xaa")(re.union (re.range "\xb5" "\xb5")(re.union (re.range "\xba" "\xba")(re.union (re.range "\xc0" "\xd6")(re.union (re.range "\xd8" "\xf6") (re.range "\xf8" "\xff"))))))))))))))) (re.++ ((_ re.loop 2 2) (re.range "\x5c" "\x5c"))(re.++ (re.+ (re.union (re.range "\x00" ")")(re.union (re.range "+" ".")(re.union (re.range "0" "9")(re.union (re.range ";" ";")(re.union (re.range "=" "=")(re.union (re.range "@" "{") (re.range "}" "\xff"))))))))(re.++ (re.range "." ".") ((_ re.loop 2 6) (re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\xaa" "\xaa")(re.union (re.range "\xb5" "\xb5")(re.union (re.range "\xba" "\xba")(re.union (re.range "\xc0" "\xd6")(re.union (re.range "\xd8" "\xf6") (re.range "\xf8" "\xff")))))))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
