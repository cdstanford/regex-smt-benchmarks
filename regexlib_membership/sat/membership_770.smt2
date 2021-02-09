;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (?:\[(?:[\u0000-\u005C]|[\u005E-\uFFFF]|\]\])+\])|(?:\u0022(?:[\u0000-\u0021]|[\u0023-\uFFFF]|\u0022\u0022)+\u0022)|(?:[a-zA-Z_][a-zA-Z0-9_]*)
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "[]]\u00DDO]"
(define-fun Witness1 () String (seq.++ "[" (seq.++ "]" (seq.++ "]" (seq.++ "\xdd" (seq.++ "O" (seq.++ "]" "")))))))
;witness2: "[]]4]]]]Q]"
(define-fun Witness2 () String (seq.++ "[" (seq.++ "]" (seq.++ "]" (seq.++ "4" (seq.++ "]" (seq.++ "]" (seq.++ "]" (seq.++ "]" (seq.++ "Q" (seq.++ "]" "")))))))))))

(assert (= regexA (re.union (re.++ (re.range "[" "[")(re.++ (re.+ (re.union (re.union (re.range "\x00" "\x5c") (re.range "^" "\xff")) (str.to_re (seq.++ "]" (seq.++ "]" ""))))) (re.range "]" "]")))(re.union (re.++ (re.range "\x22" "\x22")(re.++ (re.+ (re.union (re.union (re.range "\x00" "!") (re.range "#" "\xff")) (str.to_re (seq.++ "\x22" (seq.++ "\x22" ""))))) (re.range "\x22" "\x22"))) (re.++ (re.union (re.range "A" "Z")(re.union (re.range "_" "_") (re.range "a" "z"))) (re.* (re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_") (re.range "a" "z"))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
