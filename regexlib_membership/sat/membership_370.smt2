;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = \[\w+\]\s+((.*=.*\s+)*|[^\[])
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "[\u00E1\u00C7\u00B599\u00FF]\u00A0\u0085\u0085 \u0085\u00BD"
(define-fun Witness1 () String (seq.++ "[" (seq.++ "\xe1" (seq.++ "\xc7" (seq.++ "\xb5" (seq.++ "9" (seq.++ "9" (seq.++ "\xff" (seq.++ "]" (seq.++ "\xa0" (seq.++ "\x85" (seq.++ "\x85" (seq.++ " " (seq.++ "\x85" (seq.++ "\xbd" "")))))))))))))))
;witness2: "[\u00DF]\u00A0=\xC\u0085\u00AB;#=H \u009D"
(define-fun Witness2 () String (seq.++ "[" (seq.++ "\xdf" (seq.++ "]" (seq.++ "\xa0" (seq.++ "=" (seq.++ "\x0c" (seq.++ "\x85" (seq.++ "\xab" (seq.++ ";" (seq.++ "#" (seq.++ "=" (seq.++ "H" (seq.++ " " (seq.++ "\x9d" "")))))))))))))))

(assert (= regexA (re.++ (re.range "[" "[")(re.++ (re.+ (re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\xaa" "\xaa")(re.union (re.range "\xb5" "\xb5")(re.union (re.range "\xba" "\xba")(re.union (re.range "\xc0" "\xd6")(re.union (re.range "\xd8" "\xf6") (re.range "\xf8" "\xff")))))))))))(re.++ (re.range "]" "]")(re.++ (re.+ (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0"))))) (re.union (re.* (re.++ (re.* (re.union (re.range "\x00" "\x09") (re.range "\x0b" "\xff")))(re.++ (re.range "=" "=")(re.++ (re.* (re.union (re.range "\x00" "\x09") (re.range "\x0b" "\xff"))) (re.+ (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0"))))))))) (re.union (re.range "\x00" "Z") (re.range "\x5c" "\xff")))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
