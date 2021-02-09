;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (((\[?(?<Database>[\w]+)\]?)?\.)?(\[?(?<Owner>[\w]+)\]?)?\.)?\[?(?<Object>[\w]+)\]?
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "\x5\u00C9\u00FE[zH\u0084"
(define-fun Witness1 () String (seq.++ "\x05" (seq.++ "\xc9" (seq.++ "\xfe" (seq.++ "[" (seq.++ "z" (seq.++ "H" (seq.++ "\x84" ""))))))))
;witness2: "_\u00AA].\u00B5\u00C58.[\u00AA]\u007F"
(define-fun Witness2 () String (seq.++ "_" (seq.++ "\xaa" (seq.++ "]" (seq.++ "." (seq.++ "\xb5" (seq.++ "\xc5" (seq.++ "8" (seq.++ "." (seq.++ "[" (seq.++ "\xaa" (seq.++ "]" (seq.++ "\x7f" "")))))))))))))

(assert (= regexA (re.++ (re.opt (re.++ (re.opt (re.++ (re.opt (re.++ (re.opt (re.range "[" "["))(re.++ (re.+ (re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\xaa" "\xaa")(re.union (re.range "\xb5" "\xb5")(re.union (re.range "\xba" "\xba")(re.union (re.range "\xc0" "\xd6")(re.union (re.range "\xd8" "\xf6") (re.range "\xf8" "\xff"))))))))))) (re.opt (re.range "]" "]"))))) (re.range "." ".")))(re.++ (re.opt (re.++ (re.opt (re.range "[" "["))(re.++ (re.+ (re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\xaa" "\xaa")(re.union (re.range "\xb5" "\xb5")(re.union (re.range "\xba" "\xba")(re.union (re.range "\xc0" "\xd6")(re.union (re.range "\xd8" "\xf6") (re.range "\xf8" "\xff"))))))))))) (re.opt (re.range "]" "]"))))) (re.range "." "."))))(re.++ (re.opt (re.range "[" "["))(re.++ (re.+ (re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\xaa" "\xaa")(re.union (re.range "\xb5" "\xb5")(re.union (re.range "\xba" "\xba")(re.union (re.range "\xc0" "\xd6")(re.union (re.range "\xd8" "\xf6") (re.range "\xf8" "\xff"))))))))))) (re.opt (re.range "]" "]")))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
