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

;witness1: "\x1E/</a\u00F8\u00C096\u00DD\u00C8\u00DE>/e\u00E6V"
(define-fun Witness1 () String (seq.++ "\x1e" (seq.++ "/" (seq.++ "<" (seq.++ "/" (seq.++ "a" (seq.++ "\xf8" (seq.++ "\xc0" (seq.++ "9" (seq.++ "6" (seq.++ "\xdd" (seq.++ "\xc8" (seq.++ "\xde" (seq.++ ">" (seq.++ "/" (seq.++ "e" (seq.++ "\xe6" (seq.++ "V" ""))))))))))))))))))
;witness2: "Vc\u00B3/<\u00AAyu\u00B0>/eH"
(define-fun Witness2 () String (seq.++ "V" (seq.++ "c" (seq.++ "\xb3" (seq.++ "/" (seq.++ "<" (seq.++ "\xaa" (seq.++ "y" (seq.++ "u" (seq.++ "\xb0" (seq.++ ">" (seq.++ "/" (seq.++ "e" (seq.++ "H" ""))))))))))))))

(assert (= regexA (re.++ (re.range "/" "/")(re.++ (re.++ (re.range "<" "<") (re.opt (re.range "/" "/")))(re.++ (re.+ (re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\xaa" "\xaa")(re.union (re.range "\xb5" "\xb5")(re.union (re.range "\xba" "\xba")(re.union (re.range "\xc0" "\xd6")(re.union (re.range "\xd8" "\xf6") (re.range "\xf8" "\xff")))))))))))(re.++ (re.++ (re.* (re.union (re.range "\x00" "=") (re.range "?" "\xff"))) (re.range ">" ">")) (str.to_re (seq.++ "/" (seq.++ "e" "")))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
