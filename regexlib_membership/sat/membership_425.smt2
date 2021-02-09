;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = /(<\/?)(\w+)([^>]*>)/e
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "\u0084\u00E0/<\u00D6\u009B>/e\x7"
(define-fun Witness1 () String (seq.++ "\x84" (seq.++ "\xe0" (seq.++ "/" (seq.++ "<" (seq.++ "\xd6" (seq.++ "\x9b" (seq.++ ">" (seq.++ "/" (seq.++ "e" (seq.++ "\x07" "")))))))))))
;witness2: "/</\u00B53\u00A3\u00A4>/e"
(define-fun Witness2 () String (seq.++ "/" (seq.++ "<" (seq.++ "/" (seq.++ "\xb5" (seq.++ "3" (seq.++ "\xa3" (seq.++ "\xa4" (seq.++ ">" (seq.++ "/" (seq.++ "e" "")))))))))))

(assert (= regexA (re.++ (re.range "/" "/")(re.++ (re.++ (re.range "<" "<") (re.opt (re.range "/" "/")))(re.++ (re.+ (re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\xaa" "\xaa")(re.union (re.range "\xb5" "\xb5")(re.union (re.range "\xba" "\xba")(re.union (re.range "\xc0" "\xd6")(re.union (re.range "\xd8" "\xf6") (re.range "\xf8" "\xff")))))))))))(re.++ (re.++ (re.* (re.union (re.range "\x00" "=") (re.range "?" "\xff"))) (re.range ">" ">")) (str.to_re (seq.++ "/" (seq.++ "e" "")))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
