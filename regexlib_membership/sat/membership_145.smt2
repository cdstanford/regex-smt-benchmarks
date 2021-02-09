;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^\<(\w){1,}\>(.){0,}([\</]|[\<])(\w){1,}\>$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "<7\u00E2>\u00E5\u00A4\u00ADp<9>"
(define-fun Witness1 () String (seq.++ "<" (seq.++ "7" (seq.++ "\xe2" (seq.++ ">" (seq.++ "\xe5" (seq.++ "\xa4" (seq.++ "\xad" (seq.++ "p" (seq.++ "<" (seq.++ "9" (seq.++ ">" ""))))))))))))
;witness2: "<\u00D0><\u00AA>"
(define-fun Witness2 () String (seq.++ "<" (seq.++ "\xd0" (seq.++ ">" (seq.++ "<" (seq.++ "\xaa" (seq.++ ">" "")))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.range "<" "<")(re.++ (re.+ (re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\xaa" "\xaa")(re.union (re.range "\xb5" "\xb5")(re.union (re.range "\xba" "\xba")(re.union (re.range "\xc0" "\xd6")(re.union (re.range "\xd8" "\xf6") (re.range "\xf8" "\xff")))))))))))(re.++ (re.range ">" ">")(re.++ (re.* (re.union (re.range "\x00" "\x09") (re.range "\x0b" "\xff")))(re.++ (re.union (re.range "/" "/") (re.range "<" "<"))(re.++ (re.+ (re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\xaa" "\xaa")(re.union (re.range "\xb5" "\xb5")(re.union (re.range "\xba" "\xba")(re.union (re.range "\xc0" "\xd6")(re.union (re.range "\xd8" "\xf6") (re.range "\xf8" "\xff")))))))))))(re.++ (re.range ">" ">") (str.to_re "")))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
