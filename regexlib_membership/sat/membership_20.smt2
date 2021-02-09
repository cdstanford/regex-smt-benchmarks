;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (^(?:\w\:)?(?:/|\\\\){1}[^/|\\]*(?:/|\\){1})
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "9:/\u00AC\u00B5/"
(define-fun Witness1 () String (seq.++ "9" (seq.++ ":" (seq.++ "/" (seq.++ "\xac" (seq.++ "\xb5" (seq.++ "/" "")))))))
;witness2: "\\\u00C2/\xD\x5)f"
(define-fun Witness2 () String (seq.++ "\x5c" (seq.++ "\x5c" (seq.++ "\xc2" (seq.++ "/" (seq.++ "\x0d" (seq.++ "\x05" (seq.++ ")" (seq.++ "f" "")))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.opt (re.++ (re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\xaa" "\xaa")(re.union (re.range "\xb5" "\xb5")(re.union (re.range "\xba" "\xba")(re.union (re.range "\xc0" "\xd6")(re.union (re.range "\xd8" "\xf6") (re.range "\xf8" "\xff")))))))))) (re.range ":" ":")))(re.++ (re.union (re.range "/" "/") (str.to_re (seq.++ "\x5c" (seq.++ "\x5c" ""))))(re.++ (re.* (re.union (re.range "\x00" ".")(re.union (re.range "0" "[")(re.union (re.range "]" "{") (re.range "}" "\xff"))))) (re.union (re.range "/" "/") (re.range "\x5c" "\x5c"))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
