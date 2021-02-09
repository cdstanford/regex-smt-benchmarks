;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA =  (mailto\:|(news|(ht|f)tp(s?))\://)(([^[:space:]]+)|([^[:space:]]+)( #([^#]+)#)?) 
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: " ftp://\u00E1 4\u00DA\x1B"
(define-fun Witness1 () String (seq.++ " " (seq.++ "f" (seq.++ "t" (seq.++ "p" (seq.++ ":" (seq.++ "/" (seq.++ "/" (seq.++ "\xe1" (seq.++ " " (seq.++ "4" (seq.++ "\xda" (seq.++ "\x1b" "")))))))))))))
;witness2: "q ftps://\u00D8\u00EAE #\u00CB# \u00A6"
(define-fun Witness2 () String (seq.++ "q" (seq.++ " " (seq.++ "f" (seq.++ "t" (seq.++ "p" (seq.++ "s" (seq.++ ":" (seq.++ "/" (seq.++ "/" (seq.++ "\xd8" (seq.++ "\xea" (seq.++ "E" (seq.++ " " (seq.++ "#" (seq.++ "\xcb" (seq.++ "#" (seq.++ " " (seq.++ "\xa6" "")))))))))))))))))))

(assert (= regexA (re.++ (re.range " " " ")(re.++ (re.union (str.to_re (seq.++ "m" (seq.++ "a" (seq.++ "i" (seq.++ "l" (seq.++ "t" (seq.++ "o" (seq.++ ":" "")))))))) (re.++ (re.union (str.to_re (seq.++ "n" (seq.++ "e" (seq.++ "w" (seq.++ "s" ""))))) (re.++ (re.union (str.to_re (seq.++ "h" (seq.++ "t" ""))) (re.range "f" "f"))(re.++ (str.to_re (seq.++ "t" (seq.++ "p" ""))) (re.opt (re.range "s" "s"))))) (str.to_re (seq.++ ":" (seq.++ "/" (seq.++ "/" ""))))))(re.++ (re.union (re.+ (re.union (re.range "\x00" "Z") (re.range "\x5c" "\xff"))) (re.++ (re.+ (re.union (re.range "\x00" "Z") (re.range "\x5c" "\xff"))) (re.opt (re.++ (str.to_re (seq.++ " " (seq.++ "#" "")))(re.++ (re.+ (re.union (re.range "\x00" "\x22") (re.range "$" "\xff"))) (re.range "#" "#")))))) (re.range " " " "))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
