;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(NAME)(\s?)<?(\w*)(\s*)([0-9]*)>?$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "NAME49702999"
(define-fun Witness1 () String (seq.++ "N" (seq.++ "A" (seq.++ "M" (seq.++ "E" (seq.++ "4" (seq.++ "9" (seq.++ "7" (seq.++ "0" (seq.++ "2" (seq.++ "9" (seq.++ "9" (seq.++ "9" "")))))))))))))
;witness2: "NAME89>"
(define-fun Witness2 () String (seq.++ "N" (seq.++ "A" (seq.++ "M" (seq.++ "E" (seq.++ "8" (seq.++ "9" (seq.++ ">" ""))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (str.to_re (seq.++ "N" (seq.++ "A" (seq.++ "M" (seq.++ "E" "")))))(re.++ (re.opt (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))))(re.++ (re.opt (re.range "<" "<"))(re.++ (re.* (re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\xaa" "\xaa")(re.union (re.range "\xb5" "\xb5")(re.union (re.range "\xba" "\xba")(re.union (re.range "\xc0" "\xd6")(re.union (re.range "\xd8" "\xf6") (re.range "\xf8" "\xff")))))))))))(re.++ (re.* (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))))(re.++ (re.* (re.range "0" "9"))(re.++ (re.opt (re.range ">" ">")) (str.to_re "")))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
